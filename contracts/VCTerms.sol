// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* 
   A contract designed for vested tokens with a flexible
   lockup and linear distribution period 
*/

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract VCTerms {
    address public owner;
    mapping(address => uint) public contributed;
    mapping(address => uint) public claimed;
    uint public priceMultiplier = 100; // 100 tokens per ETH
    uint public cliffPeriodEnds;

    event Contribution(address user, uint amount);
    event Claim(address user, uint amount);

    constructor() {
        owner = msg.sender;
        cliffPeriodEnds = 1767139200; // End 2025 Unix Timestamp
    }

    function contribute() external payable {
        require(msg.value > 0, "Send some Eth");
        contributed[msg.sender] += msg.value;
        emit Contribution(msg.sender, msg.value);
    }

    function checkClaim(address _user) public view returns (uint) {
        if (block.timestamp < cliffPeriodEnds) return 0;
        uint totalOwed = contributed[_user] * priceMultiplier;
        uint vestingPeriod = 156 weeks;
        uint secondsPassed = block.timestamp - cliffPeriodEnds;
        if (secondsPassed > vestingPeriod) secondsPassed = vestingPeriod;
        uint unlocked = totalOwed * secondsPassed / vestingPeriod;
        uint amountToClaim = unlocked - claimed[msg.sender];
        return amountToClaim;
    }

    function claim(address _token) external returns (uint) {
        uint amountAvailable = checkClaim(msg.sender);
        require(amountAvailable > 0, "Nothing to claim");
        claimed[msg.sender] += amountAvailable;
        IERC20(_token).transfer(msg.sender,amountAvailable);
        emit Claim(msg.sender, amountAvailable);
        return amountAvailable;
    }

    function claimToken(address _token) external {
        require(msg.sender == owner, "only owner has access");
        uint balance = IERC20(_token).balanceOf(address(this));
        IERC20(_token).transfer(msg.sender, balance);
    }

    function claimETH() external {
        require(msg.sender == owner, "only owner has access");
        payable(msg.sender).transfer(address(this).balance);
    }

}
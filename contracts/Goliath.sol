// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.15;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Send out ERC20 Rewards
contract Rewards {
  
    address rewardToken = 0xd0A1E359811322d97991E03f863a0C30C2cF029C; // Kovan WETH

    mapping(address => uint) public startTS;

    uint public deployedTS;
    uint public rewardsPerDay = 1e18; // wei, 18 decimals
    uint public totalParticipants;

    constructor() {
        deployedTS = block.timestamp;
    }

    function addMe() public {
        // logic to decide who deserves rewards
        if (startTS[msg.sender] == 0) totalParticipants += 1;
        startTS[msg.sender] = block.timestamp;
        
    }

    function claimRewards() public {
        require(startTS[msg.sender] != 0, "No record of user account");
        uint rewardAmount = (block.timestamp - startTS[msg.sender]) * rewardsPerDay / 1 days;
        startTS[msg.sender] = block.timestamp;
        IERC20(rewardToken).transfer(msg.sender, rewardAmount);
    }

    function userEarnings(address _user) public view returns(uint256) {
        if (startTS[_user] == 0) return 0;
        uint rewardAmount = (block.timestamp - startTS[_user]) * rewardsPerDay / 1 days;
        return rewardAmount;
    }
}

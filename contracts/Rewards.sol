// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Send out ERC20 Rewards
contract Rewards {
    address rewardToken = 0xd0A1E359811322d97991E03f863a0C30C2cF029C; // Kovan WETH

    mapping(address => uint) public startTS;

    uint public deployedTS;
    uint rewardsPerDay = 1e18; // wei, 18 decimals

    constructor() {
        deployedTS = block.timestamp;
    }

    function addMe() public {
        // logic to decide who deserves rewards
        startTS[msg.sender] = block.timestamp;
    }

    function claimRewards() public {
        require(startTS[msg.sender] != 0, "No record of user account");
        require(startTS[msg.sender] < block.timestamp - 1 days, "No Rewards Due On First Day");
        uint rewardAmount = block.timestamp - startTS[msg.sender] * rewardsPerDay / 1 days;
        startTS[msg.sender] = block.timestamp;
        IERC20(rewardToken).transfer(msg.sender, rewardAmount);
    }
}

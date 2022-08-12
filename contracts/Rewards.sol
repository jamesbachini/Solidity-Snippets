// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Send out ERC20 Rewards
contract Rewards {
  
    address rewardToken = 0xd0A1E359811322d97991E03f863a0C30C2cF029C; // Kovan WETH

    mapping(address => uint) public startTS;

    uint public deployedTS;
    uint rewardsPerDay = 10000000; // wei, 18 decimals
    uint secondsPerDay = 86400;

    constructor() {
        deployedTS = block.timestamp;
    }

    function addMe() public {
        // logic to decide who deserves rewards
        startTS[msg.sender] = block.timestamp;
    }

    function claimRewards() public {
        require(startTS[msg.sender] != 0, 'No record of user account');
        require(startTS[msg.sender] < block.timestamp - secondsPerDay, 'No Rewards Due');
        // uint daysDue = block.timestamp - startTS[msg.sender] / secondsPerDay;
        uint rewardAmount = block.timestamp - startTS[msg.sender] * rewardsPerDay / secondsPerDay;
        startTS[msg.sender] = block.timestamp;
        IERC20(rewardToken).transfer(msg.sender, rewardAmount);
    }
}

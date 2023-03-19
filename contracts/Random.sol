// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

// Generate a random enough number for most applications
contract RandomishNumbers {

    function newRandom() private view returns (uint) {
        uint randomNumber = block.prevrandao;
        return randomNumber;
    }

    function oldRandom() private view returns (uint) {
        uint hashNumber =  uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, msg.sender)));
        return hashNumber % 100;
    }
}

// For more secure randomness consider an off-chain oracle service such as https://docs.chain.link/docs/chainlink-vrf/

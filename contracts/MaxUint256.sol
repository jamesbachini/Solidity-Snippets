// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15; 

contract MaxUint256 {
    function uintMax() external pure returns(uint256) {
        return type(uint256).max;
    }
}

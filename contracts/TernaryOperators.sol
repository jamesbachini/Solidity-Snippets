// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract TernaryOperators {

    function lowerValue(uint _a, uint _b) public pure returns (uint) {
        // (query ? true : false)
        uint value = (_a < _b ? _a : _b);
        return value;
    }

}
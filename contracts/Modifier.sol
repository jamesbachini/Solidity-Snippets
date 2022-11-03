// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract Modifier {
    modifier onlyVitalik() {
        require(msg.sender == 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045);
        _;
    }

    function doSomething() external onlyVitalik {
        // Only vitalik's wallet can call this function
    }
}
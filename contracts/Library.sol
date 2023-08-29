// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

library TestLibrary {
    function subtract(uint a, uint b) internal pure returns (uint) {
        return a - b;
    }
}

// import "./TestLibrary.sol";

contract MyContract {
    function func(uint a, uint b) public pure returns (uint) {
        return TestLibrary.subtract(a, b);
    }
}

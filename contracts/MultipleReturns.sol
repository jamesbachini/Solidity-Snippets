// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract MultipleReturns {

    function returnVars() internal pure returns(uint256,uint256,uint256) {
        uint256 var1 = 1;
        uint256 var2 = 2;
        uint256 var3 = 3;
        return (var1,var2,var3);
    }

    function getVar() external pure returns(uint256) {
        // (uint256 a, uint256 b, uint256 c) = returnVars();
        (,uint256 b,) = returnVars();
        return (b);
    }
}
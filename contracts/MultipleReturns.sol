// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract MultipleReturns {
    function returnVars() internal pure returns(uint,uint,uint) {
        uint var1 = 1;
        uint var2 = 2;
        uint var3 = 3;
        return (var1,var2,var3);
    }

    function getVar() external pure returns(uint) {
        // (uint a, uint b, uint c) = returnVars();
        (,uint b,) = returnVars();
        return (b);
    }
}
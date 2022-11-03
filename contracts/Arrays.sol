// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

// Arrays Example
contract Arrays {

    uint[] public myArray;
    uint[4] public myFixedArray = [3,5,1,8];
    uint[][] public nestedArray;

    function arrayPush(uint _newNumber) public {
        myArray.push(_newNumber);
    }

    function arrayLoop() public view {
        for (uint i=0; i<myArray.length; i++) { // unbounded loop DoS warning
            // do something with myArray[i]
        }
    }

    function arrayLength() public view returns(uint) {
        return myArray.length;
    }
}

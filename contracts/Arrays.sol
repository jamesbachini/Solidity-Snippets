// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

// Arrays Example
contract Arrays {

    uint[] public myArray = [2,4,6,8,10,12];
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

    function delByIndex(uint _i) public {
        for (uint i = _i; i < myArray.length - 1; ++i) {
            myArray[i] = myArray[i+1];
        }
        myArray.pop();
    }
}

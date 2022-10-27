// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

// Arrays Example
contract Arrays {

  address[] public myArray;
  address[2] public myFixedArray = [0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045, 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045];
  address[][] public nestedArray;

  function arrayPush(address _newAddress) public {
    myArray.push(_newAddress);
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

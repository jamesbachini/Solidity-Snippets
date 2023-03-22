// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract Parent {
    uint public parentVariable;

    function parentFunc(uint _parentVariable, function(uint) external _callback) public {
        parentVariable = _parentVariable;
         _callback(_parentVariable * 2);
    }
}

contract Child {
    address public parentAddress;
    uint public childVariable;

    constructor(address _parentAddress) {
        parentAddress = _parentAddress;
    }
    
    function run(uint _newVar) public {
        Parent(parentAddress).parentFunc(_newVar, this.callback);
    }
    
    function callback(uint _childVariable) external {
        childVariable = _childVariable * 2;
    }
}
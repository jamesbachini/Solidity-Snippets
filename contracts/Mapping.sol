// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

// Mapping Addresses To Balances
contract AddressMap {

    mapping(address => uint) public balances;

    function addFunds() public {
        balances[msg.sender] = 1000;
    }

    function checkFunds(address _addr) view returns(uint) {
        return balances[_addr];
    }
}

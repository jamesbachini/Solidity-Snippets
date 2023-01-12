// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Distributor {
    address developer = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address lawfirm = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    address bizdev = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;

    fallback() external payable {
        uint developerAmount = msg.value * 90 / 100;
        uint lawfirmAmount = msg.value * 5 / 100;
        uint bizdevAmount = msg.value - developerAmount - lawfirmAmount;

        payable(developer).transfer(developerAmount);
        payable(lawfirm).transfer(lawfirmAmount);
        payable(bizdev).transfer(bizdevAmount);
    }
}

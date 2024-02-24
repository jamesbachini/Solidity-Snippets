// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Escrow {

    struct Agreement {
        address bob;
        address alice;
        address arbitrator;
        uint amount;
        bool bobIn;
        bool aliceIn;
    }

    Agreement[] public agreements;

    function newAgreement(address _bob, address _alice, uint _amount) external returns (uint) {
        require(_bob != _alice, "same buyer and seller");
        agreements.push(Agreement(_bob,_alice,msg.sender,_amount,false,false));
        return agreements.length - 1;
    }

    function deposit(uint _id) external payable {
        if (msg.sender == agreements[_id].bob && msg.value == agreements[_id].amount) {
            agreements[_id].bobIn = true;
        }
        else if (msg.sender == agreements[_id].alice && msg.value == agreements[_id].amount) {
            agreements[_id].aliceIn = true;
        }
    }

    function refund(uint _id) external {
        if (msg.sender == agreements[_id].bob && agreements[_id].bobIn == true) {
            agreements[_id].bobIn = false;
            payable(agreements[_id].bob).transfer(agreements[_id].amount);
        }
        if (msg.sender == agreements[_id].alice && agreements[_id].aliceIn == true) {
            agreements[_id].aliceIn = false;
            payable(agreements[_id].alice).transfer(agreements[_id].amount);
        }
    }

    function complete(uint _id, address _winner) external {
        require(msg.sender == agreements[_id].arbitrator, "Only arbitrator can complete");
        require(agreements[_id].bobIn == true, "Bob has not paid");
        require(agreements[_id].aliceIn == true, "Alice has not paid");
        
        if (agreements[_id].bob == _winner) {
            agreements[_id].bobIn = false;
            agreements[_id].aliceIn = false;
            payable(agreements[_id].bob).transfer(agreements[_id].amount * 2);
        }
        else if (agreements[_id].alice == _winner) {
            agreements[_id].bobIn = false;
            agreements[_id].aliceIn = false;
            payable(agreements[_id].alice).transfer(agreements[_id].amount * 2);
        }
    }
}
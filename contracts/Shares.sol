// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/**
 * A simplified permissionless version of FriendtechSharesV1 contract
 */

contract Shares {
    address public protocolFeeDestination;
    uint256 public protocolFeePercent;

    constructor() {
        protocolFeeDestination = msg.sender;
        protocolFeePercent = 1e15;
    }

    event Trade(address trader, address subject, bool isBuy, uint256 shareAmount, uint256 ethAmount, uint256 protocolEthAmount, uint256 supply);

    mapping(address => mapping(address => uint256)) public sharesBalance;
    mapping(address => uint256) public sharesSupply;

    function getPrice(uint256 supply, uint256 amount) public pure returns (uint256) {
        uint256 sum1 = supply == 0 ? 0 : (supply - 1 )* (supply) * (2 * (supply - 1) + 1) / 6;
        uint256 sum2 = supply == 0 && amount == 1 ? 0 : (supply - 1 + amount) * (supply + amount) * (2 * (supply - 1 + amount) + 1) / 6;
        uint256 summation = sum2 - sum1;
        return summation * 1 ether / 16000;
    }

    function getBuyPrice(address sharesSubject, uint256 amount) public view returns (uint256) {
        return getPrice(sharesSupply[sharesSubject], amount);
    }

    function getSellPrice(address sharesSubject, uint256 amount) public view returns (uint256) {
        return getPrice(sharesSupply[sharesSubject] - amount, amount);
    }

    function getBuyPriceAfterFee(address sharesSubject, uint256 amount) public view returns (uint256) {
        uint256 price = getBuyPrice(sharesSubject, amount);
        uint256 protocolFee = price * protocolFeePercent / 1 ether;
        return price + protocolFee;
    }

    function getSellPriceAfterFee(address sharesSubject, uint256 amount) public view returns (uint256) {
        uint256 price = getSellPrice(sharesSubject, amount);
        uint256 protocolFee = price * protocolFeePercent / 1 ether;
        return price - protocolFee;
    }

    function buyShares(address sharesSubject, uint256 amount) public payable {
        uint256 supply = sharesSupply[sharesSubject];
        require(supply > 0 || sharesSubject == msg.sender, "Only the shares' subject can buy the first share");
        uint256 price = getPrice(supply, amount);
        uint256 protocolFee = price * protocolFeePercent / 1 ether;
        require(msg.value >= price + protocolFee, "Insufficient payment");
        sharesBalance[sharesSubject][msg.sender] = sharesBalance[sharesSubject][msg.sender] + amount;
        sharesSupply[sharesSubject] = supply + amount;
        emit Trade(msg.sender, sharesSubject, true, amount, price, protocolFee, supply + amount);
        (bool success1, ) = protocolFeeDestination.call{value: protocolFee}("");
        require(success1, "Unable to send funds");
    }

    function sellShares(address sharesSubject, uint256 amount) public payable {
        uint256 supply = sharesSupply[sharesSubject];
        require(supply > amount, "Cannot sell the last share");
        uint256 price = getPrice(supply - amount, amount);
        uint256 protocolFee = price * protocolFeePercent / 1 ether;
        require(sharesBalance[sharesSubject][msg.sender] >= amount, "Insufficient shares");
        sharesBalance[sharesSubject][msg.sender] = sharesBalance[sharesSubject][msg.sender] - amount;
        sharesSupply[sharesSubject] = supply - amount;
        emit Trade(msg.sender, sharesSubject, false, amount, price, protocolFee, supply - amount);
        (bool success1, ) = msg.sender.call{value: price - protocolFee}("");
        (bool success2, ) = protocolFeeDestination.call{value: protocolFee}("");
        require(success1 && success2, "Unable to send funds");
    }
}
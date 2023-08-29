// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StaggeredSale is ERC20, Ownable {
    uint public immutable deployedTimestamp;
    uint private immutable mintLimit = 90_000_000 * 10 ** decimals();
    uint public saleMinted;
    uint public startDate;
    uint public endDate;
    uint startPricePerToken = 0.0001 ether;
    uint endPricePerToken = 0.00013 ether;
    bool tokenLive;
    event PublicSale(address to, uint amountReceived, uint ethContributed);

    constructor() ERC20("Staggered Sale Token", "SST") {
        deployedTimestamp = block.timestamp;
        startDate = deployedTimestamp + 7 days;
        endDate = deployedTimestamp + 37 days;
        tokenLive = true;
        // mint team tokens
        _mint(msg.sender, 10_000_000 * 10 ** decimals());
        tokenLive = false;
    }

    function pricePerDay(uint _day) public view returns (uint) {
        uint startDay = 0;
        uint endDay = (endDate - startDate) / 1 days;
        uint timeProgress = _day - startDay;
        uint totalDuration = endDay - startDay;
        uint priceProgress = ((endPricePerToken - startPricePerToken) * timeProgress) / totalDuration;
        uint currentPrice = startPricePerToken + priceProgress;
        return currentPrice;
    }

    function nextPriceUpdate() public view returns (uint, uint) {
        uint daysPassed = (block.timestamp - startDate) / 1 days;
        uint nextUpdateTS = startDate + ((daysPassed + 1) * 1 days);
        uint secondsLeft = nextUpdateTS - block.timestamp;
        uint nextPrice = pricePerDay(daysPassed + 1);
        return (secondsLeft, nextPrice);
    }

    function staggeredPublicSalePrice() public view returns (uint) {
        uint daysPassed = (block.timestamp - startDate) / 1 days;
        uint currentPrice = pricePerDay(daysPassed);
        return currentPrice;
    }

    // function not used but if you want to do a linear price increase this is how
    function linearPublicSalePrice() public view returns (uint) {
        uint timeProgress = block.timestamp - startDate;
        uint totalDuration = endDate - startDate;
        uint priceProgress = ((endPricePerToken - startPricePerToken) * timeProgress) / totalDuration;
        uint currentPrice = startPricePerToken + priceProgress;
        return currentPrice;
    }

    function buyTokens() external payable {
        require(block.timestamp > startDate, "too soon");
        require(block.timestamp < endDate, "too late");
        require(msg.value > 0.00001 ether, "min amount in not met");
        uint _price = staggeredPublicSalePrice();
        uint _amount = msg.value / _price * 10 ** decimals();
        require(_amount > 0, "min amount out not met");
        require(saleMinted + _amount < mintLimit, "sold out");
        saleMinted += _amount;
        payable(owner()).transfer(msg.value); 
        tokenLive = true;
        _mint(msg.sender, _amount);
        tokenLive = false;
        emit PublicSale(msg.sender, _amount, msg.value);
    }

    function goLive() external onlyOwner {
        require(block.timestamp > endDate, "too soon");
        tokenLive = true; 
        uint unsoldTokens = mintLimit - saleMinted;
        saleMinted += unsoldTokens;
        if (unsoldTokens > 0)
            _mint(owner(), unsoldTokens);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override {
        require(tokenLive == true, "Token transfers not enabled yet");
        super._beforeTokenTransfer(from, to, amount);
    }
}
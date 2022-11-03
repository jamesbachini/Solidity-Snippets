// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface AlternateIERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

interface IWEth is IERC20 {
    function withdraw(uint wad) external;
    function deposit() external payable;
}

interface IAave {
    function deposit(address asset,uint amount,address onBehalfOf,uint16 referralCode) external;
    function borrow(address asset,uint amount,uint interestRateMode,uint16 referralCode,address onBehalfOf) external;
    function repay(address asset,uint amount,uint rateMode,address onBehalfOf) external returns (uint);
    function withdraw(address asset,uint amount,address to) external returns (uint);
    function getUserAccountData(address user) external view returns (uint totalCollateralETH, uint totalDebtETH, uint availableBorrowsETH, uint currentLiquidationThreshold, uint ltv, uint healthFactor);
}

contract InterfaceExample {
    address private wethAddress = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address private aaveAddress = 0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9;

    function depositWeth() external {
        uint wethBalance = IWEth(wethAddress).balanceOf(address(this));
        IAave(aaveAddress).deposit(wethAddress,wethBalance,address(this),0);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IWEth is IERC20 {
  function withdraw(uint256 wad) external;
  function deposit() external payable;
}

interface IAave {
  function deposit(address asset,uint256 amount,address onBehalfOf,uint16 referralCode) external;
  function borrow(address asset,uint256 amount,uint256 interestRateMode,uint16 referralCode,address onBehalfOf) external;
  function repay(address asset,uint256 amount,uint256 rateMode,address onBehalfOf) external returns (uint256);
  function withdraw(address asset,uint256 amount,address to) external returns (uint256);
  function getUserAccountData(address user) external view returns (uint256 totalCollateralETH, uint256 totalDebtETH, uint256 availableBorrowsETH, uint256 currentLiquidationThreshold, uint256 ltv, uint256 healthFactor);
}

contract InterfaceExample {

  address private wethAddress = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
  address private aaveAddress = 0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9;

  function depositWeth() external {
    uint256 wethBalance = IWEth(wethAddress).balanceOf(address(this));
    IAave(aaveAddress).deposit(wethAddress,wethBalance,address(this),0);
  }

}
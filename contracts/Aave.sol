// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IAave {
  function deposit(address asset,uint256 amount,address onBehalfOf,uint16 referralCode) external;
  function borrow(address asset,uint256 amount,uint256 interestRateMode,uint16 referralCode,address onBehalfOf) external;
  function repay(address asset,uint256 amount,uint256 rateMode,address onBehalfOf) external returns (uint256);
  function withdraw(address asset,uint256 amount,address to) external returns (uint256);
  function getUserAccountData(address user) external view returns (uint256 totalCollateralETH, uint256 totalDebtETH, uint256 availableBorrowsETH, uint256 currentLiquidationThreshold, uint256 ltv, uint256 healthFactor);
}

contract Borrowing {
  address public aave = 0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9;
  address public steth = 0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84;
  address public weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

  function borrow() payable public {
    uint256 balance = 1e18; // Assumes contract holds stETH balance
    IAave(aave).deposit(steth,balance,address(this),0);
    uint256 borrowAmount = balance * 6 / 10; // 60% collateral to loan
    IAave(aave).borrow(weth,borrowAmount,2,0,address(this));
  }
}
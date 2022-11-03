// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IAave {
    function deposit(address asset,uint amount,address onBehalfOf,uint16 referralCode) external;
    function borrow(address asset,uint amount,uint interestRateMode,uint16 referralCode,address onBehalfOf) external;
    function repay(address asset,uint amount,uint rateMode,address onBehalfOf) external returns (uint);
    function withdraw(address asset,uint amount,address to) external returns (uint);
    function getUserAccountData(address user) external view returns (uint totalCollateralETH, uint totalDebtETH, uint availableBorrowsETH, uint currentLiquidationThreshold, uint ltv, uint healthFactor);
}

contract Borrowing {
    address public aave = 0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9;
    address public steth = 0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84;
    address public weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    function borrow() payable public {
        uint balance = 1e18; // Assumes contract holds stETH balance
        IAave(aave).deposit(steth,balance,address(this),0);
        uint borrowAmount = balance * 6 / 10; // 60% collateral to loan
        IAave(aave).borrow(weth,borrowAmount,2,0,address(this));
    }
}
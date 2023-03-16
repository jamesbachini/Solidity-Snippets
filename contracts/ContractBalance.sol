// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
interface IERC20 {
    function balanceOf(address account) external view returns (uint);
}

contract BalanceExample {
    uint public ethBalance = address(this).balance;
    address private wethTokenAddress = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    uint public wethBalance = IERC20(wethTokenAddress).balanceOf(address(this));
}

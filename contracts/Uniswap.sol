// SPDX-License-Identifier: MIT
pragma solidity >=0.8.14;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';

contract SwapTokens {
  address public _uinswapV3RouterAddress = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
  address private _daiAddress = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
  address private _wethAddress = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2; 

  function buyWeth(uint amountUSD) internal {
    uint256 deadline = block.timestamp + 15;
    uint24 fee = 3000;
    address recipient = address(this);
    uint256 amountIn = amountUSD; // includes 18 decimals
    uint256 amountOutMinimum = 0;
    uint160 sqrtPriceLimitX96 = 0;
    require(IERC20(_daiAddress).approve(address(_uinswapV3RouterAddress), amountIn), 'DAI approve failed');
    
    ISwapRouter.ExactInputSingleParams memory params = ISwapRouter.ExactInputSingleParams(
      _daiAddress,
      _wethAddress,
      fee,
      recipient,
      deadline,
      amountIn,
      amountOutMinimum,
      sqrtPriceLimitX96
    );
    ISwapRouter(_uinswapV3RouterAddress).exactInputSingle(params);
  }
}
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

contract SwapTokens {
  address public uinswapV3RouterAddress = 0xE592427A0AEce92De3Edee1F18E0157C05861564; // Kovan

	function buyWeth(uint amountUSD) internal {
		uint256 deadline = block.timestamp + 15;
		uint24 fee = 3000;
		address recipient = address(this);
		uint256 amountIn = amountUSD; // includes 18 decimals
		uint256 amountOutMinimum = 0;
		uint160 sqrtPriceLimitX96 = 0;
		require(daiToken.approve(address(uinswapV3RouterAddress), amountIn), 'DAI approve failed');
		
    ISwapRouter.ExactInputSingleParams memory params = ISwapRouter.ExactInputSingleParams(
			daiAddress,
			wethAddress,
			fee,
			recipient,
			deadline,
			amountIn,
			amountOutMinimum,
			sqrtPriceLimitX96
		);
		uniswapRouter.exactInputSingle(params);
		uniswapRouter.refundETH();
	}
}
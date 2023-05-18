  // SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IPool {
    function flash(address recipient, uint amount0, uint amount1, bytes calldata data) external;
    function token0() external view returns (address);
    function token1() external view returns (address);
}

interface IFactory {
    function getPool(address token0, address token1, uint24 fee) external view returns (address);
}

contract UniswapFlashLoan {
    address public pool;
    address public factory;
    address public token0;
    address public token1;
    uint public balanceCheck0;
    uint public balanceCheck1;

    constructor(address _token0, address _token1, uint24 _fee) {
        // 0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6, 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984, 3000
        factory = 0x1F98431c8aD98523631AE4a59f267346ea31F984; // Uniswap V3 Factory Contract
        pool = IFactory(factory).getPool(_token0, _token1, _fee);
        token0 = IPool(pool).token0(); // note they get swapped around
        token1 = IPool(pool).token1();
    }

    function flashLoan(uint _token0Amount, uint _token1Amount) external {
        bytes memory data = abi.encode(_token0Amount, _token1Amount, msg.sender);
        IPool(pool).flash(address(this), _token0Amount, _token1Amount, data);
    }

    function uniswapV3FlashCallback(uint _fee0, uint _fee1, bytes calldata _data) external {
        require(msg.sender == address(pool), "Only Callback");
        (uint token0Amount, uint token1Amount, address msgSender) = abi.decode(_data, (uint, uint, address));
        // do something to generate enough to payback the loan and fee
        balanceCheck0 = IERC20(token0).balanceOf(address(this));
        balanceCheck1 = IERC20(token1).balanceOf(address(this));
        if (_fee0 > 0) IERC20(token0).transfer(address(pool), token0Amount + _fee0);
        if (_fee1 > 0) IERC20(token1).transfer(address(pool), token1Amount + _fee1);
    }  
}
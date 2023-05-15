// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./ERC20Mock.sol";


contract UniswapV3SwapperMock {
    using SafeERC20 for IERC20;

    struct SwapTokensData {
        address tokenIn;
        uint256 tokenInId;
        address tokenOut;
        uint256 tokenOutId;
    }

    struct SwapAmountData {
        uint256 amountIn;
        uint256 shareIn;
        uint256 amountOut;
        uint256 shareOut;
    }

    struct YieldBoxData {
        bool withdrawFromYb;
        bool depositToYb;
    }

    struct SwapData {
        SwapTokensData tokensData;
        SwapAmountData amountData;
        YieldBoxData yieldBoxData;
    }


    constructor(address) {}

    //Add more overloads if needed

    function getOutputAmount(
        SwapData calldata swapData,
        bytes calldata
    ) external pure returns (uint256 amountOut) {
        return swapData.amountData.amountIn;
    }

    function getInputAmount(
        SwapData calldata swapData,
        bytes calldata
    ) external pure returns (uint256) {
        return swapData.amountData.amountOut;
    }

    function swap(
        SwapData calldata swapData,
        uint256,
        address,
        bytes memory
    ) external returns (uint256 amountOut, uint256 shareOut) {
        IERC20(swapData.tokensData.tokenIn).safeTransferFrom(msg.sender, address(this), swapData.amountData.amountIn);
        ERC20Mock(payable(swapData.tokensData.tokenOut)).freeMint(swapData.amountData.amountIn);
        IERC20(swapData.tokensData.tokenOut).safeTransfer(msg.sender, swapData.amountData.amountIn);
        return (swapData.amountData.amountIn,swapData.amountData.amountIn);
    }

    function buildSwapData(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 shareIn,
        bool withdrawFromYb,
        bool depositToYb
    ) external pure returns (SwapData memory) {
        return
            _buildSwapData(
                tokenIn,
                tokenOut,
                0,
                0,
                amountIn,
                shareIn,
                withdrawFromYb,
                depositToYb
            );
    }

    function buildSwapData(
        uint256 tokenInId,
        uint256 tokenOutId,
        uint256 amountIn,
        uint256 shareIn,
        bool withdrawFromYb,
        bool depositToYb
    ) external pure returns (SwapData memory) {
        return
            _buildSwapData(
                address(0),
                address(0),
                tokenInId,
                tokenOutId,
                amountIn,
                shareIn,
                withdrawFromYb,
                depositToYb
            );
    }

    function _buildSwapData(
        address tokenIn,
        address tokenOut,
        uint256 tokenInId,
        uint256 tokenOutId,
        uint256 amountIn,
        uint256 shareIn,
        bool withdrawFromYb,
        bool depositToYb
    ) internal pure returns (SwapData memory swapData) {
        SwapAmountData memory swapAmountData;
        swapAmountData.amountIn = amountIn;
        swapAmountData.shareIn = shareIn;

        SwapTokensData memory swapTokenData;
        swapTokenData.tokenIn = tokenIn;
        swapTokenData.tokenOut = tokenOut;
        swapTokenData.tokenInId = tokenInId;
        swapTokenData.tokenOutId = tokenOutId;

        YieldBoxData memory swapYBData;
        swapYBData.withdrawFromYb = withdrawFromYb;
        swapYBData.depositToYb = depositToYb;

        swapData.tokensData = swapTokenData;
        swapData.amountData = swapAmountData;
        swapData.yieldBoxData = swapYBData;
    }
}
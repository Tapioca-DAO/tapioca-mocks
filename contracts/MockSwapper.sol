// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "@boringcrypto/boring-solidity/contracts/libraries/BoringERC20.sol";
import "tapioca-sdk/dist/contracts/YieldBox/contracts/YieldBox.sol";

/// @notice Always gives out the minimum requested amount, if it has it.
/// @notice Do not use the other functions.
contract MockSwapper {
    using BoringERC20 for IERC20;

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

    YieldBox private immutable yieldBox;

    constructor(YieldBox _yieldBox) {
        yieldBox = _yieldBox;
    }

    function getOutputAmount(
        SwapData calldata,
        bytes calldata
    ) external pure returns (uint256) {
        return 0;
    }

    function getInputAmount(
        SwapData calldata,
        bytes calldata
    ) external pure returns (uint256) {
        return 0;
    }

    function swap(
        SwapData calldata swapData,
        uint256 amountOutMin,
        address to,
        bytes calldata
    ) external returns (uint256 amountOut, uint256 shareOut) {
        shareOut = yieldBox.toShare(
            swapData.tokensData.tokenOutId,
            amountOutMin,
            true
        );
        amountOut = amountOutMin;
        yieldBox.transfer(
            address(this),
            to,
            swapData.tokensData.tokenOutId,
            shareOut
        );
    }

    //leverage interface support;
    function buildSwapData(
        address,
        address,
        uint256,
        uint256,
        bool,
        bool
    ) external view returns (SwapData memory) {}

    function buildSwapData(
        uint256,
        uint256,
        uint256,
        uint256,
        bool,
        bool
    ) external view returns (SwapData memory) {}
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "@boringcrypto/boring-solidity/contracts/libraries/BoringERC20.sol";

interface IAsset {
    // solhint-disable-previous-line no-empty-blocks
}

contract BalancerVaultMock {
    using BoringERC20 for IERC20;

    enum SwapKind {
        GIVEN_IN,
        GIVEN_OUT
    }

    struct FundManagement {
        address sender;
        bool fromInternalBalance;
        address payable recipient;
        bool toInternalBalance;
    }

    struct SingleSwap {
        bytes32 poolId;
        SwapKind kind;
        IAsset assetIn;
        IAsset assetOut;
        uint256 amount;
        bytes userData;
    }

    function swap(
        SingleSwap memory singleSwap,
        FundManagement memory,
        uint256,
        uint256
    ) external payable returns (uint256 amountCalculated) {
        IERC20(address(singleSwap.assetIn)).safeTransferFrom(
            msg.sender,
            address(this),
            singleSwap.amount
        );
        IERC20(address(singleSwap.assetOut)).safeTransfer(
            msg.sender,
            singleSwap.amount
        );
        return singleSwap.amount;
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {IZeroXSwapper} from "tapioca-periph/interfaces/periph/IZeroXSwapper.sol";

interface IERC20Mock {
    function freeMint(uint256 _val) external;
}

contract ZeroXSwapperMock is IZeroXSwapper {
    function swap(SZeroXSwapData calldata swapData, uint256 amountIn, uint256 minAmountOut)
        public
        payable
        returns (uint256 amountOut)
    {
        // Transfer tokens to this contract
        swapData.sellToken.transferFrom(msg.sender, address(this), amountIn);

        // Get tokens
        IERC20Mock(address(swapData.buyToken)).freeMint(minAmountOut);
        amountOut = minAmountOut;

        // Transfer the bought tokens to the sender
        swapData.buyToken.transfer(msg.sender, minAmountOut);
    }

    /**
     * @notice Payable fallback to allow this contract to receive protocol fee refunds.
     * https://0x.org/docs/0x-swap-api/guides/use-0x-api-liquidity-in-your-smart-contracts#payable-fallback
     */
    receive() external payable {}
}

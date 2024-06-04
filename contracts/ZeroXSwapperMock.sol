// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {IZeroXSwapper} from "tapioca-periph/interfaces/periph/IZeroXSwapper.sol";
import {ICluster} from "tapioca-periph/interfaces/periph/ICluster.sol";

interface IERC20Mock {
    function freeMint(uint256 _val) external;
}

contract ZeroXSwapperMock is IZeroXSwapper, Ownable {
    ICluster public cluster;

    constructor(ICluster _cluster, address _owner) {
        cluster = _cluster;
        transferOwnership(_owner);
    }

    function swap(SZeroXSwapData calldata swapData, uint256 amountIn, uint256 minAmountOut)
        public
        payable
        returns (uint256 amountOut)
    {
        if (!cluster.isWhitelisted(0, msg.sender)) revert SenderNotValid(msg.sender);
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

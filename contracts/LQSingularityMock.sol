// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

interface IBidderMock {}

interface IPenroseMock {}

interface ILiquidationQueueMock {
    struct LiquidationQueueMeta {
        uint256 activationTime; // Time needed before a bid can be activated for execution
        uint256 minBidAmount; // Minimum bid amount
        address feeCollector; // Address of the fee collector
        IBidderMock bidExecutionSwapper; //Allows swapping USDO to collateral when a bid is executed
        IBidderMock usdoSwapper; //Allows swapping any other stablecoin to USDO
    }

    function init(LiquidationQueueMeta calldata, address singularity) external;
}

contract LQSingularityMock {
    IPenroseMock immutable penrose;

    uint256 immutable assetId;

    uint256 constant EXCHANGE_RATE_PRECISION = 1e18;

    constructor(IPenroseMock _penrose, uint256 _assetId) {
        penrose = _penrose;
        assetId = _assetId;
    }

    function initLq(
        ILiquidationQueueMock liquidationQueue,
        ILiquidationQueueMock.LiquidationQueueMeta calldata lqMeta
    ) external {
        liquidationQueue.init(lqMeta, address(this));
    }
}

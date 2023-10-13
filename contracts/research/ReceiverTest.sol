// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract ReceiverTest {
    uint256 public totalEth;

    receive() external payable {}

    function receiveSomeEth() external payable {
        totalEth += msg.value;
    }
}

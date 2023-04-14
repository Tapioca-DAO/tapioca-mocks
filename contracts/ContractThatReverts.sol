// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract ContractThatReverts {
    uint256 public count;
    string public revertStr = "This method reverted. So awesome!";

    function shouldRevert(uint256 _count) external {
        count = _count;
        revert(revertStr);
    }

    function shouldNotRevert(uint256 _count) external {
        count = _count;
    }
}

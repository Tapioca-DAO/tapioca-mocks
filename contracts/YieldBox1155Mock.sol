// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract YieldBox1155Mock is ERC1155 {
    mapping(address user => mapping(uint256 assetId => uint256 amount)) public balances;

    constructor() ERC1155("YieldBox") {}

    function depositAsset(uint256 assetId, address to, uint256 amount, uint256)
        external
        returns (uint256 amountOut, uint256 shareOut)
    {
        balances[to][assetId] += amount;
        return (amount, amount);
    }

    function withdraw(uint256 assetId, address from, uint256 amount, uint256)
        external
        returns (uint256 amountOut, uint256 shareOut)
    {
        require(balances[from][assetId] >= amount, "not enough");
        balances[from][assetId] -= amount;
        return (amount, amount);
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract YieldBox1155Mock is ERC1155 {
    constructor() ERC1155("YieldBox") {}

    function depositAsset(uint256 assetId, address to, uint256 amount)
        external
        returns (uint256 amountOut, uint256 shareOut)
    {
        _mint(to, assetId, amount, "");
        return (amount, amount);
    }

    function withdraw(uint256 assetId, address from, uint256 amount)
        external
        returns (uint256 amountOut, uint256 shareOut)
    {
        require(balanceOf(from, assetId) >= amount, "not enough");
        _burn(from, assetId, amount);
        return (amount, amount);
    }

    function transfer(address from, address to, uint256 assetId, uint256 amount)
        external
        returns (uint256 amountOut, uint256 shareOut)
    {
        require(balanceOf(from, assetId) >= amount, "not enough");
        _safeTransferFrom(from, to, assetId, amount, "");
        return (amount, amount);
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {IYieldBoxTokenType} from "tap-utils/interfaces/yieldbox/IYieldBox.sol";
import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract YieldBox1155Mock is ERC1155 {
    constructor() ERC1155("YieldBox") {}

    uint256 public nextAssetId = 100;

    function depositAsset(uint256 assetId, address to, uint256 amount)
        external
        returns (uint256 amountOut, uint256 shareOut)
    {
        _mint(to, assetId, amount, "");
        return (amount, amount);
    }

    // YieldBox interface
    function depositAsset(uint256 assetId, address from, address to, uint256 amount, uint256 share)
        external
        returns (uint256 amountOut, uint256 shareOut)
    {
        amount = amount == 0 ? toAmount(assetId, share, false) : amount;
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

    function registerAsset(IYieldBoxTokenType tokenType, address contractAddress, address strategy, uint256 tokenId)
        external
        returns (uint256 assetId)
    {
        return nextAssetId++;
    }

    function toAmount(uint256 assetId, uint256 share, bool roundUp) public view returns (uint256 amount) {
        return share;
    }

    function toShare(uint256 assetId, uint256 _amount, bool roundUp) public view returns (uint256 amount) {
        return _amount;
    }

    function withdraw(uint256 assetId, address from, address to, uint256 amount, uint256 share)
        external
        returns (uint256 amountOut, uint256 shareOut)
    {
        if (share == 0) {
            share = toShare(assetId, amount, false);
        }
        if (amount == 0) {
            amount = toAmount(assetId, share, false);
        }
        require(balanceOf(from, assetId) >= amount, "not enough");
        _burn(from, assetId, amount);
        return (amount, amount);
    }
}

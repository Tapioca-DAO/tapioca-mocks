// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@boringcrypto/boring-solidity/contracts/interfaces/IERC20.sol";
import "@boringcrypto/boring-solidity/contracts/libraries/BoringERC20.sol";

contract TOFTMock {
    using BoringERC20 for IERC20;

    address public erc20_;
    address public tAsset;

    constructor(address _erc20, address _tAsset) {
        erc20_ = _erc20;
        tAsset = _tAsset;
    }

    function wrap(
        address _fromAddress,
        address _toAddress,
        uint256 _amount
    ) external payable {
        IERC20(erc20_).safeTransferFrom(_fromAddress, address(this), _amount);
        IERC20(tAsset).safeTransfer(_toAddress, _amount);
    }

    function unwrap(address _toAddress, uint256 _amount) external {
        IERC20(tAsset).safeTransferFrom(msg.sender, address(this), _amount);
        IERC20(erc20_).safeTransfer(_toAddress, _amount);
    }

    function erc20() external view returns (address) {
        return erc20_;
    }
}

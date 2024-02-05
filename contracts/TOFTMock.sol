// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@boringcrypto/boring-solidity/contracts/interfaces/IERC20.sol";
import "@boringcrypto/boring-solidity/contracts/libraries/BoringERC20.sol";
import "@boringcrypto/boring-solidity/contracts/ERC20.sol";

contract TOFTMock is ERC20WithSupply {
    using BoringERC20 for IERC20;

    address public erc20_;

    constructor(address _erc20) {
        erc20_ = _erc20;
    }

    function wrap(address _fromAddress, address _toAddress, uint256 _amount) external payable {
        _mint(_toAddress, _amount);
        if (erc20_ != address(0)) {
            IERC20(erc20_).safeTransferFrom(_fromAddress, address(this), _amount);
        } else {
            require(msg.value == _amount, "TOFTMock: failed to received ETH");
        }
    }

    function unwrap(address _toAddress, uint256 _amount) external {
        _burn(msg.sender, _amount);
        if (erc20_ != address(0)) {
            IERC20(erc20_).safeTransfer(_toAddress, _amount);
        } else {
            (bool sent,) = _toAddress.call{value: _amount}("");
            require(sent, "TOFTMock: failed to transfer ETH");
        }
    }

    function erc20() external view returns (address) {
        return erc20_;
    }

    receive() external payable {}
}

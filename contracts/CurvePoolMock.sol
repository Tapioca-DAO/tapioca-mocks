// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "@boringcrypto/boring-solidity/contracts/libraries/BoringERC20.sol";

interface IUSDOMock {
    function mint(address _to, uint256 _amount) external;

    function burn(address _from, uint256 _amount) external;
}

contract CurvePoolMock {
    using BoringERC20 for IERC20;

    mapping(uint256 => address) public coins;

    uint256 public divider;

    constructor(address token0, address token1) {
        coins[0] = token0;
        coins[1] = token1;
        divider = 1;
    }

    function setDivider(uint256 div) external {
        divider = div;
    }

    function get_dy(int128, int128, uint256 dx) external view returns (uint256) {
        if (divider == 0) return 0;
        return dx / divider;
    }

    function exchange(int128, int128 j, uint256 dx, uint256) external {
        if (divider == 0) return;
        address tokenOut = coins[uint256(uint128(j))];
        uint256 freeMintAmount = dx / divider;
        IUSDOMock(tokenOut).mint(address(this), freeMintAmount);
        IERC20(tokenOut).safeTransfer(msg.sender, freeMintAmount);
    }
}

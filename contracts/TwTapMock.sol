// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "@boringcrypto/boring-solidity/contracts/libraries/BoringERC20.sol";

contract TwTwapMock {
    using BoringERC20 for IERC20;

    IERC20[] public rewardTokens;
    mapping(IERC20 => uint256) public rewardTokenIndex;

    function addRewardToken(IERC20 token) external returns (uint256) {
        uint256 i = rewardTokens.length;
        rewardTokens.push(token);
        rewardTokenIndex[token] = i;
        return i;
    }

    function distributeReward(
        uint256 _rewardTokenId,
        uint256 _amount
    ) external {
        IERC20 rewardToken = rewardTokens[_rewardTokenId];
        rewardToken.safeTransferFrom(msg.sender, address(this), _amount);
    }
}

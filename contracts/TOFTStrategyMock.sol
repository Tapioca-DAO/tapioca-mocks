// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import "@boringcrypto/boring-solidity/contracts/BoringOwnable.sol";
import "@boringcrypto/boring-solidity/contracts/interfaces/IERC20.sol";
import "@boringcrypto/boring-solidity/contracts/libraries/BoringERC20.sol";

import "tapioca-sdk/dist/contracts/YieldBox/contracts/strategies/BaseStrategy.sol";

interface IERC20Mock {
    function toggleRestrictions() external;

    function freeMint(uint256 _val) external;
}

contract TOFTStrategyMock is BaseERC20Strategy, BoringOwnable, ReentrancyGuard {
    using BoringERC20 for IERC20;

    IERC20Mock public rewardToken;
    uint256 public vaultAmount;

    constructor(
        IYieldBox _yieldBox,
        address _toft,
        address _rewardToken
    ) BaseERC20Strategy(_yieldBox, _toft) {
        rewardToken = IERC20Mock(_rewardToken);
    }

    function name() external pure override returns (string memory name_) {
        return "TOFTStrategyMock";
    }

    function description()
        external
        pure
        override
        returns (string memory description_)
    {
        return "TOFTStrategyMock";
    }

    function compoundAmount() public view returns (uint256 result) {
        uint256 decimals = IERC20(contractAddress).safeDecimals();
        return 2 * (10 ** decimals); //2 tokens
    }

    function compound(bytes memory) public {
        uint256 decimals = IERC20(contractAddress).safeDecimals();
        uint256 claimable = 2 * (10 ** decimals);
        rewardToken.freeMint(claimable);

        vaultAmount += claimable; //simulate swap from rewardToken to contractAddress
    }

    function emergencyWithdraw() external onlyOwner returns (uint256 result) {
        compound("");
        return vaultAmount;
    }

    // ************************* //
    // *** PRIVATE FUNCTIONS *** //
    // ************************* //
    function _currentBalance() internal view override returns (uint256 amount) {
        if (vaultAmount == 0) return 0;
        uint256 _compoundAmount = compoundAmount();
        return vaultAmount + _compoundAmount;
    }

    function _deposited(uint256 amount) internal override nonReentrant {
        vaultAmount += amount;
    }

    function _withdraw(
        address to,
        uint256 amount
    ) internal override nonReentrant {
        uint256 available = _currentBalance();
        require(available >= amount, "amount not valid");
        IERC20(contractAddress).safeTransfer(to, amount);

        if (amount > vaultAmount) {
            vaultAmount = 0;
        } else {
            vaultAmount -= amount;
        }
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

contract GLPManagerMock {
    uint256 public glpPrice;

    constructor(uint256 _glpPrice) {
        if (_glpPrice < 1e30) {
            revert("GLPManagerMock: invalid price. Needs to be at least 1e27. Precision is 30 decimals.");
        }
        glpPrice = _glpPrice;
    }

    function setGlpPrice(uint256 _glpPrice) public {
        if (_glpPrice < 1e30) {
            revert("GLPManagerMock: invalid price. Needs to be at least 1e27. Precision is 30 decimals.");
        }
        glpPrice = _glpPrice;
    }

    function getPrice(bool) external view returns (uint256) {
        return glpPrice;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract UsdoMock is ERC20Permit, Ownable {
    mapping(address => bool) public whitelist;

    uint8 private _decimals;

    constructor(string memory _name, string memory _symbol, uint8 decimals_, address _owner)
        ERC20(_name, _symbol)
        ERC20Permit(_name)
    {
        _decimals = decimals_;
        transferOwnership(_owner);
    }

    function setWhitelist(address _addr, bool _value) external onlyOwner {
        whitelist[_addr] = _value;
    }

    function decimals() public view override returns (uint8) {
        return _decimals;
    }

    function mint(address _to, uint256 _amount) external {
        require(whitelist[msg.sender], "ERC20Mock: caller is not whitelisted");
        _mint(_to, _amount);
    }
}

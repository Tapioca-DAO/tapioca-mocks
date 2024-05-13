// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC721Mock is ERC721, Ownable {
    uint256 private _tokenIds;

    constructor(string memory _name, string memory _symbol, address _owner) ERC721(_name, _symbol) {
        transferOwnership(_owner);
    }

    function mint(address to) public onlyOwner returns (uint256) {
        _tokenIds += 1;
        _mint(to, _tokenIds);
        return _tokenIds;
    }
}

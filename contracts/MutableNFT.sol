// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MutableNFT is ERC721 {
    using Counters for Counters.Counter;

    mapping(string => bool) private takenNames;
    mapping(uint256 => Attr) public attributes;

    struct Attr {
        uint8 eXPBalance;
    }
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("MutableNFT", "MTE") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://YOUR_API/api/erc721";
    }

    function mint(address to) public returns (uint256) {
        require(_tokenIdCounter.current() < 3, "");
        _tokenIdCounter.increment();
        _safeMint(to, _tokenIdCounter.current());

        return _tokenIdCounter.current();
    }
}

// Code taken from https://www.freecodecamp.org/news/how-to-make-an-nft/
/* Idea: add ΞThernaut 
                  XP
*/

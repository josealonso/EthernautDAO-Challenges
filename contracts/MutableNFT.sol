// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MutableNFT is ERC721, Ownable {
    using Counters for Counters.Counter;

    mapping(uint256 => Attr) public attributes;

    struct Attr {
        uint8 eXPBalance;
    }
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("MutableNFT", "MTE") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://YOUR_API/api/erc721";
    }

    function _burn(uint256 tokenId) internal override(ERC721) {
        super._burn(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function mint(
        address to,
        uint256 tokenId,
        uint8 _eXPBalance
    ) public onlyOwner {
        _safeMint(to, tokenId);
        attributes[tokenId] = Attr(_eXPBalance);
    }
}

// Code taken from https://www.freecodecamp.org/news/how-to-make-an-nft/
/* Idea: add ΞThernaut 
                  XP
*/

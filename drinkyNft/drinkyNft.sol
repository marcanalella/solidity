// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DrinkyNFT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;
    uint256 public immutable maxSupply = 500;

    mapping(address => bool) public hasMinted;

    // Fix: Pass msg.sender to Ownable constructor
    constructor() ERC721("DrinkyNFT", "DRNKY") Ownable(msg.sender) {}

    function mint(string memory _tokenURI) external {
        require(nextTokenId < maxSupply, "All NFTs have been minted");
        require(!hasMinted[msg.sender], "This address has already minted an NFT");

        hasMinted[msg.sender] = true;

        uint256 tokenId = nextTokenId;
        nextTokenId++;

        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, _tokenURI);
    }
}

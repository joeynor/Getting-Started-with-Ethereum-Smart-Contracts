// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

// This contract will inherit from the Ownable and NFT Token Metadata contracts from nibbstack
import "https://github.com/nibbstack/erc721/blob/master/src/contracts/tokens/nf-token-metadata.sol";
import "https://github.com/nibbstack/erc721/blob/master/src/contracts/ownership/ownable.sol";


contract MyNFT is NFTokenMetadata, Ownable {

    // Contract constructor.
    //   Runs at deployment.
    //   Sets name and symbol of NFT.
    constructor() {
        nftName = "MyNFT";
        nftSymbol = "MNF";
    } // constructor

    // This function will mint a new NFT and deposit it in the wallet at the _to address.
    //   Each token must have a Token ID.
    //   The URL property indicates the digital asset the token holder has access to.
    function mint(address _to, uint256 _tokenId, string calldata _url) external onlyOwner {
        super._mint(_to, _tokenId);
        super._setTokenUri(_tokenId, _url);
    } // mint

} // MyNFT

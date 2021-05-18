pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import {
    ERC721Full
} from "./openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";
import {SafeMath} from "./openzeppelin-solidity/contracts/math/SafeMath.sol";

/**
 * @notice - This is the NFT contract for a photo
 */
contract PhotoNFT is ERC721Full {
    using SafeMath for uint256;

    uint256 public currentPhotoId = 0;

    constructor(
        address owner, /// Initial owner (Seller)
        string memory _nftName,
        string memory _nftSymbol,
        string memory _tokenURI, /// [Note]: TokenURI is URL include ipfs hash
        uint256 photoPrice,
        uint256 mintSupply
    ) public ERC721Full(_nftName, _nftSymbol) {
        mint(owner, mintSupply, _tokenURI);
    }

    /**
     * @dev mint a photoNFT
     * @dev tokenURI - URL include ipfs hash
     */
    function mint(
        address to,
        uint256 mintSupply,
        string memory tokenURI
    ) public returns (bool) {
        /// Mint a new PhotoNFT
        for (uint256 i = currentPhotoId + 1; i <= mintSupply; i++) {
            currentPhotoId++;
            _mint(to, i);
            _setTokenURI(i, tokenURI);
        }
        return true;
    }
}

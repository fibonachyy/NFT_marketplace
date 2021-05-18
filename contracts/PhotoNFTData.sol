pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import {
    PhotoNFTDataStorages
} from "./photo-nft-data/commons/PhotoNFTDataStorages.sol";
import {PhotoNFT} from "./PhotoNFT.sol";

/**
 * @notice - This is the storage contract for photoNFTs
 */
contract PhotoNFTData is PhotoNFTDataStorages {
    address[] public photoAddresses;

    constructor() public {}

    /**
     * @notice - Save metadata of a photoNFT
     */
    function saveMetadataOfPhotoNFT(
        address[] memory _photoAddresses,
        PhotoNFT _photoNFT,
        string memory _photoNFTName,
        string memory _photoNFTSymbol,
        address _ownerAddress,
        uint256 _photoPrice,
        string memory _ipfsHashOfPhoto,
        uint256 maxSupply,
        uint256 photoId
    ) public returns (bool) {
        /// Save metadata of a photoNFT of photo
        Photo memory photo =
            Photo({
                photoNFT: _photoNFT,
                photoNFTName: _photoNFTName,
                photoNFTSymbol: _photoNFTSymbol,
                photoPrice: _photoPrice,
                ipfsHashOfPhoto: _ipfsHashOfPhoto,
                status: "Open",
                reputation: 0,
                maxSupply: maxSupply,
                ownerAddress: _ownerAddress,
                photoId: photoId
            });
        photos.push(photo);
        /// Update photoAddresses
        photoAddresses = _photoAddresses;
    }

    /**
     * @notice - Update owner address of a photoNFT by transferring ownership
     */
    function updateOwnerOfPhotoNFT(
        PhotoNFT _photoNFT,
        address _newOwner,
        uint256 photoId
    ) public returns (bool) {
        /// Identify photo's index
        uint256 photoIndex = getPhotoIndex(_photoNFT, photoId);

        /// Update metadata of a photoNFT of photo
        Photo storage photo = photos[photoIndex];
        require(
            _newOwner != address(0),
            "A new owner address should be not empty"
        );
        photo.ownerAddress = _newOwner;
    }

    /**
     * @notice - Update status ("Open" or "Cancelled")
     */
    function updateStatus(
        PhotoNFT _photoNFT,
        string memory _newStatus,
        uint256 photoId
    ) public returns (Photo[] memory) {
        /// Identify photo's index
        uint256 photoIndex = getPhotoIndex(_photoNFT, photoId);

        /// Update metadata of a photoNFT of photo
        Photo storage photo = photos[photoIndex];
        photo.status = _newStatus;
        return photos;
    }

    ///-----------------
    /// Getter methods
    ///-----------------
    function getPhoto(uint256 index) public view returns (Photo memory _photo) {
        Photo memory photo = photos[index];
        return photo;
    }

    function getPhotoIndex(PhotoNFT photoNFT, uint256 photoId)
        public
        view
        returns (uint256 _photoIndex)
    {
        address PHOTO_NFT = address(photoNFT);

        /// Identify member's index
        uint256 photoIndex;
        for (uint256 i = 0; i < photoAddresses.length; i++) {
            if (photoAddresses[i] == PHOTO_NFT) {
                if (photos[i].photoId == photoId) {
                    photoIndex = i;
                }
            }
        }

        return photoIndex;
    }

    function getPhotoByNFTAddress(PhotoNFT photoNFT, uint256 photoId)
        public
        view
        returns (Photo memory _photo)
    {
        address PHOTO_NFT = address(photoNFT);

        /// Identify member's index
        Photo memory photo;
        uint256 photoIndex;
        for (uint256 i = 0; i < photoAddresses.length; i++) {
            if (photoAddresses[i] == PHOTO_NFT) {
                if (photos[i].photoId == photoId) {
                    photo = photos[i];
                }
            }
        }
        return photo;
    }

    function getAllPhotos() public view returns (Photo[] memory _photos) {
        return photos;
    }
}

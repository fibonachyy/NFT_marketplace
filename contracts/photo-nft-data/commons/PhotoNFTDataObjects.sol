pragma solidity ^0.5.0;

import {PhotoNFT} from "../../PhotoNFT.sol";

contract PhotoNFTDataObjects {
    struct Photo {
        /// [Key]: index of array
        PhotoNFT photoNFT;
        string photoNFTName;
        string photoNFTSymbol;
        uint256 photoPrice;
        string ipfsHashOfPhoto;
        string status; /// "Open" or "Cancelled"
        uint256 reputation;
        uint256 maxSupply;
        address ownerAddress;
        uint256 photoId;
    }
}

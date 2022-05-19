//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract WhelpsOfTheWest is Ownable, ERC1155Supply {
    using Strings for uint256;

    //string baseURI;
    string public notRevealedUri;
    uint256 public cost;
    uint256 public maxSupply;
    bool public isPaused = false;
    string public name = "Whelps of the west";
    bool public revealed=false;
    bool public mintingAllowed;
    uint256 public count=0;
    

    constructor(
        uint256 _cost,
        uint256 _maxSupply       
    ) ERC1155("https://ipfs.io/ipfs/Your CID/{id}") {
        cost = _cost;
        maxSupply = _maxSupply;       
    }

    function mintBatch(uint256 length) public payable {
        require(mintingAllowed == true, "Minting not allowed yet");
        uint256[] memory amounts=new uint256[](length);
        uint256[] memory ids=new uint256[](length);
        for(uint i=1;i<=length;i++){
            amounts[i-1]=1;
            ids[i-1]=count+i;
        }
        require(count + length <= maxSupply);
        count+=length;
        require(!isPaused);
        require(length > 0);

        if (msg.sender != owner()) {
            require(msg.value >= cost * length);

            
        }
        _mintBatch(msg.sender, ids, amounts, "");
    }


    function beginMinting() public onlyOwner {
		mintingAllowed = true;
	}

	function pauseMinting() public onlyOwner {
		mintingAllowed = false;
	}


    function uri(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        if (revealed == false) {
            return notRevealedUri;
        }

        return string(abi.encodePacked("https://Your CID/",Strings.toString(tokenId),".json"));
    }

    // Only Owner Functions
    function setIsRevealed(bool _state) public onlyOwner {
         revealed = _state;
    }

    function setCost(uint256 _newCost) public onlyOwner {
        cost = _newCost;
    }

    function setBaseExtension(string memory _newBaseExtension)
        public
        onlyOwner
    {
        // baseExtension = _newBaseExtension;
    }

    function setIsPaused(bool _state) public onlyOwner {
        isPaused = _state;
    }

    function withdraw() public payable onlyOwner {
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract IPFSERC1155SimpleContract is ERC1155, Ownable{



     
    uint256 public constant IVYSAUR = 1;
    uint256 public constant VENUSAUR = 2;
    uint256 public constant CHARMANDER = 3;

    mapping (uint256 => string) private _uris;



    constructor() public ERC1155("https://bafybeidnmjvtahfyab4pc4vcp6v6omvrq5ha3tvprkwpugnflhzaynpvzy.ipfs.dweb.link/{id}.json") Ownable(msg.sender)  {
        _mint(msg.sender,IVYSAUR,100,"");
        _mint(msg.sender,VENUSAUR,100,"");
        _mint(msg.sender,CHARMANDER,100,"");
    }



    function uri(uint256  tokenId) override public view returns(string memory){
        return (_uris[tokenId]);
    }


    function setTokenUri(uint256 tokenId,string memory _uri) public {
        _uris[tokenId] = _uri;
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleContactERC1155 is ERC1155, Ownable{

    uint256[] supplies = [50,100,150];
    uint256[] minted = [0,0,0];
    uint256[] rates = [0.05 ether,0.1 ether,0.025 ether];


    constructor() ERC1155("") Ownable(msg.sender) {}

    function mint(uint256 id, uint256 amount)
        public
        onlyOwner
    {
        require(id <= supplies.length,"Token doesnt exist");
        require(id > 0,"Token doesnt exist");

        uint256 index = id - 1;

        require(minted[index] + amount <= supplies[index],"Not enough supply");


        _mint(msg.sender, id, amount, "");

        minted[index] += amount;

    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }
}
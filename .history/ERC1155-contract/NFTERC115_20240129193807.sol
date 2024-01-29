// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFTERC115 is ERC1155, ERC1155Pausable, Ownable, ERC1155Supply {

    uint256 public  publicPrice = 0.00001 ether;
    uint256 maxSupply = 1;
    uint256 public allowListPrice = 0.01 ether;
    bool public publicMinitOpen = false;

    constructor()
        ERC1155("ipfs://Qmaa6TuP2s9pSKczHF4rwWhTKUdygrrDs8RmYYqCjP3Hye/")
        Ownable(msg.sender)
    {}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint( uint256 id, uint256 amount)  
        public
        payable
        onlyOwner
    {
        require(id < 2,"Sorry look like you are trying to mint the wrong NFT");
        require(msg.value == publicPrice * amount,"Wrong not enough moeny sent!");

        require(totalSupply(id) <= maxSupply,"Sorry we have mint out");
        
        _mint(msg.sender, id, amount, "");
    }

     function uri(uint256 _id) override public view  returns (string memory) {
        require(exists(_id),"URI: nonexistent token");
        return string(abi.encodePacked(super.uri(_id),Strings.toString(_id),".jsonn"));
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
        internal
        override(ERC1155, ERC1155Pausable, ERC1155Supply)
    {
        super._update(from, to, ids, values);
    }

    function withdraw(address _addr) external onlyOwner{
        uint balance = address(this).balance;
        payable(_addr).transfer(balance);
    }

    function allowListMint(uint256 id,uint256 amount) public  payable {
        require(msg.value == allowListPrice * amount);
        require(totalSupply(id)+ amount <= maxSupply,"Sorry we have mint out!");
        _mint(msg.sender, id, amount, "");

    }
}

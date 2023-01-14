// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract FakeNFTMarketplace{
    uint price =0.001 ether;
    mapping(uint=>address) public tokens;

    function purchase(uint _tokenID) external payable{
        require(msg.value>=price, "incorrect price input");
        tokens[_tokenID]=msg.sender;
    }
    function getPrice()external view returns(uint){
        return price;
    }
    function avalible(uint _tokenId) external view returns(bool){
        if (tokens[_tokenId]==address(0)){
            return true;
        }
        return false;
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

interface ICryptoDevsNFT{
    function balanceOf(address _address)external view returns(uint);

    function tokenOfOwnerByIndex(address owner, uint256 index)external view returns (uint256);
}
interface IFakeNFTMarketplace{
    function purchase(uint _tokenID) external payable;

    function getPrice()external view returns(uint);

    function avalible(uint _tokenId) external view returns(bool);
}

contract CryptoDevsDAO is Ownable {

    IFakeNFTMarketplace nftMarketplace;
    ICryptoDevsNFT cryptoDevsNFT;

    constructor(address _nftMarketplace, address _cryptoDevsNFT) payable {
    nftMarketplace = IFakeNFTMarketplace(_nftMarketplace);
    cryptoDevsNFT = ICryptoDevsNFT(_cryptoDevsNFT);
    }


    struct Proposal{
        uint _tokenId;

        uint deadline;

        uint yesVotes;

        uint noVotes;

        bool executed;

        mapping(uint=>bool)voters;
    }

    mapping(uint=>Proposal)public Proposals;

    uint256 public numOfProposals;

    modifier onlyNFTHolder(){
        require(cryptoDevsNFT.balanceOf(msg.sender)>0, "You are not a DAO member");
        _;
    }

    modifier activeProposalsOnly(uint proposalIndex){
        require(Proposals[proposalIndex].deadline>block.timestamp, "Proposal Timeframe is Over");
        _;
    }
    modifier inactiveProposalsOnly(uint proposalIndex){
        require(Proposals[proposalIndex].deadline<block.timestamp, "Proposal is still being voted on");
        _;
    }

    enum Vote{
        yes,
        no
    }
    
    function createProposal(uint _tokenId)external onlyNFTHolder returns(uint){
        require(nftMarketplace.avalible(_tokenId), "Token is not for sale");
        Proposal storage proposal= Proposals[numOfProposals];
        proposal._tokenId=_tokenId;
        proposal.deadline = block.timestamp + 5 minutes;
        numOfProposals++;
        return numOfProposals-1;
    }
    
    function voteOnProposal(uint256 proposalIndex, Vote vote) external nftHolderOnly activeProposalOnly(proposalIndex){
        Proposal storage proposal = proposals[proposalIndex];

        uint256 voterNFTBalance = cryptoDevsNFT.balanceOf(msg.sender);
        uint256 numVotes = 0;

    
        for (uint256 i = 0; i < voterNFTBalance; i++) {
            uint256 tokenId = cryptoDevsNFT.tokenOfOwnerByIndex(msg.sender, i);
            if (proposal.voters[tokenId] == false) {
                numVotes++;
                proposal.voters[tokenId] = true;
            }
        }
        require(numVotes > 0, "ALREADY_VOTED");

        if (vote == Vote.yes) {
            proposal.yesVotes += numVotes;
        } else {
            proposal.noVotes += numVotes;
        }
    
    }
    function executeProposal(uint proposalIndex)external onlyNFTHolder inactiveProposalsOnly(proposalIndex){
        Proposal storage proposal =Proposals[proposalIndex];
        if(proposal.yesVotes>proposal.noVotes){
            uint _price = nftMarketplace.getPrice();
            require(address(this).balance>=_price, "Not enough ether to purchse NFT");
            nftMarketplace.purchase{value: _price}(proposal._tokenId);
        }
        proposal.executed=true;
    }
    function withdraw()external onlyOwner{
        uint amount =address(this).balance;
        require(amount>0, "Nothing to withdraw");
        payable(owner()).transfer(amount);
    }
    receive() external payable{}

    fallback() external payable{}

}


        
    




    

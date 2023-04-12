pragma solidity ^0.8.0;

contract VotingSystem {
    
    struct Candidate {
        string name;
        uint voteCount;
    }
    
    mapping (address => bool) public voters;
    Candidate[] public candidates;
    uint public totalVotes;
    
    constructor(string[] memory candidateNames) {
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
        }
    }
    
    function vote(uint candidateIndex) public {
        require(!voters[msg.sender], "You have already voted.");
        require(candidateIndex < candidates.length, "Invalid candidate index.");
        
        voters[msg.sender] = true;
        candidates[candidateIndex].voteCount += 1;
        totalVotes += 1;
    }
    
    function getWinner() public view returns (string memory) {
        uint winningVoteCount = 0;
        string memory winnerName;
        
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winnerName = candidates[i].name;
            }
        }
        
        return winnerName;
    }
}

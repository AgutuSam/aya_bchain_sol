// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./voteReg.sol";
import "./candidate.sol";

contract VotingContract {
    VoteReg public voterContract;
    VoteCandidate public candidateContract;

    struct Vote {
        uint256 divisionalCommissioner;
        uint256 provincialCommissioner;
        uint256 president;
    }

    mapping(address => Vote) public votes;
    mapping(address => bool) public hasVoted;

    constructor(address _voterContractAddress, address _candidateContractAddress) {
        voterContract = VoteReg(_voterContractAddress);
        candidateContract = VoteCandidate(_candidateContractAddress);
    }

    function vote(uint256 divisionalCommissioner, uint256 provincialCommissioner, uint256 president) public {
        require(!hasVoted[msg.sender], "You have already voted.");

        votes[msg.sender] = Vote(divisionalCommissioner, provincialCommissioner, president);
        hasVoted[msg.sender] = true;

        if (divisionalCommissioner != 0) {
            candidateContract.addVote(divisionalCommissioner, msg.sender);
        }

        if (provincialCommissioner != 0) {
            candidateContract.addVote(provincialCommissioner, msg.sender);
        }

        if (president != 0) {
            candidateContract.addVote(president, msg.sender);
        }
    }

    function getVote(address voter) public view returns (Vote memory) {
        return votes[voter];
    }

    function hasVotedFunc(address voter) public view returns (bool) {
        return hasVoted[voter];
    }
}

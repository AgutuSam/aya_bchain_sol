// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./shared.sol";

contract VoterContract {
    struct Voter {
        uint256 voterId;
        string firstName;
        string lastName;
        uint256 nationalId;
        string province;
        string division;
        bool hasVoted;
        mapping(string => uint256) votes; // mapping for votes by level
    }

    mapping(uint256 => Voter) private voters;
    uint256[] public voterIds;
    uint256[] public voterNatIds;

    ShareContract sharedData;

    event VoterAdded(uint256 voterId, uint256 nationalId);

    constructor(address _sharedDataAddress) {
        sharedData = ShareContract(_sharedDataAddress);
    }

    function addVoter(
        uint256 voterId,
        string memory firstName,
        string memory lastName,
        uint256 nationalId,
        string memory province,
        string memory division
    ) public {
        require(voters[nationalId].voterId == 0, "Voter already registered");
        Voter storage voter = voters[nationalId];
        voter.voterId = voterId;
        voter.firstName = firstName;
        voter.lastName = lastName;
        voter.nationalId = nationalId;
        voter.province = province;
        voter.division = division;
        voter.hasVoted = false;
        voterIds.push(voterId);
        voterNatIds.push(nationalId);
        emit VoterAdded(voterId, nationalId);
    }

    function getVoters() public view returns (uint256[] memory) {
        return voterIds;
    }

    function getNatVoters() public view returns (uint256[] memory) {
        return voterNatIds;
    }

    function getVoter(uint256 nationalId) public view returns (
        uint256 voterId,
        string memory firstName,
        string memory lastName,
        uint256 natID,
        string memory province,
        string memory division,
        bool hasVoted
    ) {
        Voter storage voter = voters[nationalId];
        return (
            voter.voterId,
            voter.firstName,
            voter.lastName,
            voter.nationalId,
            voter.province,
            voter.division,
            voter.hasVoted
        );
    }

    function getVotes(uint256 nationalId) public view returns (string[] memory levels, uint256[] memory candidateIds) {
        Voter storage voter = voters[nationalId];
        uint256 length = 3; // Assuming we have 3 levels (division, province, president)
        levels = new string[](length);
        candidateIds = new uint256[](length);

        levels[0] = "divisional_commissioner";
        levels[1] = "provincial_commissioner";
        levels[2] = "president";

        for (uint256 i = 0; i < length; i++) {
            candidateIds[i] = voter.votes[levels[i]];
        }
    }

    function updateVote(uint256 nationalId, string memory level, uint256 candidateId) public {
        require(voters[nationalId].voterId != 0, "Voter not registered");
        voters[nationalId].votes[level] = candidateId;
    }
}

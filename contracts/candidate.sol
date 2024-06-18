// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./shared.sol";

contract CandidateContract {
    struct Candidate {
        uint256 candidateId;
        string firstName;
        string lastName;
        string party;
        string partyLogo;
        string profileImage;
        string contestedLevel;
        string province;
        string division;
        uint256[] votes;
    }

    mapping(uint256 => Candidate) public candidates;
    uint256 public candidateCount;

    ShareContract public sharedContract;

    event CandidateAdded(uint256 candidateId);

    constructor(address _sharedContractAddress) {
        sharedContract = ShareContract(_sharedContractAddress);
    }

    modifier onlySharedContract() {
        require(msg.sender == address(sharedContract), "Caller is not the SharedContract");
        _;
    }

    function addCandidate(
        string memory _firstName,
        string memory _lastName,
        string memory _party,
        string memory _partyLogo,
        string memory _profileImage,
        string memory _contestedLevel,
        string memory _province,
        string memory _division
    ) public onlySharedContract {
        candidateCount++;
        candidates[candidateCount] = Candidate(
            candidateCount,
            _firstName,
            _lastName,
            _party,
            _partyLogo,
            _profileImage,
            _contestedLevel,
            _province,
            _division,
            new uint256[](0)
        );

        emit CandidateAdded(candidateCount);
    }

    function getCandidates() public view returns (Candidate[] memory) {
        Candidate[] memory candidateList = new Candidate[](candidateCount);
        for (uint256 i = 1; i <= candidateCount; i++) {
            candidateList[i - 1] = candidates[i];
        }
        return candidateList;
    }

    function getCandidatesByLevel(string memory _contestedLevel) public view returns (Candidate[] memory) {
    uint256 count = 0;
    for (uint256 i = 1; i <= candidateCount; i++) {
        if (keccak256(abi.encodePacked(candidates[i].contestedLevel)) == keccak256(abi.encodePacked(_contestedLevel))) {
            count++;
        }
    }

    Candidate[] memory candidateList = new Candidate[](count);
    uint256 index = 0;
    for (uint256 i = 1; i <= candidateCount; i++) {
        if (keccak256(abi.encodePacked(candidates[i].contestedLevel)) == keccak256(abi.encodePacked(_contestedLevel))) {
            candidateList[index] = candidates[i];
            index++;
        }
    }
    return candidateList;
}


    function updateCandidateVotes(uint256 _candidateId, uint256 _voterAddress) public {
        require(_candidateId > 0 && _candidateId <= candidateCount, "Invalid candidate ID");
        candidates[_candidateId].votes.push(_voterAddress);
    }
}

// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract Main {

    struct candidateStruct {
        string name;
        string proposal;
    }

    mapping (uint => candidateStruct) candidateMapping;
    mapping (address => uint) voterMapping;
    mapping (address => uint) delegateMapping;
    mapping (uint => uint) voteCount;

    uint public candidate_count;
    uint private delegate_count;
    uint public voter_count;

    string public electionState = "NOT STARTED";

    function addCandidate(string memory _name, string memory _proposal, address owner) public {
        if (owner == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4) {
            candidate_count ++;
            candidateMapping[candidate_count] = candidateStruct(_name, _proposal);
        }
        else {
        revert("Only the contract owner can add candidates.");
        }
    }

    function addVoter(address _voter, address owner) public {
        if (_voter != address(0)) {
            if (owner == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4) {
                if (voterMapping[_voter] != 0)  {
                    revert("Voter already exists.");
                }
                else {
                    voter_count ++;
                    voterMapping[_voter] = voter_count;
                }
            }
            else {
            revert("Only the contract owner can add candidates.");
            }
        }
    }

    function delegateVote(address _delegate, address _voter) public {
        if (_voter != address(0)) {
            if ((voterMapping[_voter] != 0)) {
                delegateMapping[_delegate] = delegate_count;
                voterMapping[_voter] = 0;
                }
            else {
                revert("Please register the voter first. ");
            }
        }
        else {
            revert("Invalid address. ");
        }
    }

    function endElection(address owner) public {
        if ((keccak256(abi.encodePacked(electionState)) == keccak256(abi.encodePacked("ENDED")))) {
            revert("Election has ended. ");
        }
        else if ((keccak256(abi.encodePacked(electionState)) == keccak256(abi.encodePacked("ONGOING")))) {
            if ( owner == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4) {
            electionState = "ENDED";
        }
        else if ((keccak256(abi.encodePacked(electionState)) == keccak256(abi.encodePacked("NOT STARTED")))) {
            revert("Election has not started yet. ");
            }
        }
    }

    function startElection(address owner) public {
        if ((keccak256(abi.encodePacked(electionState)) == keccak256(abi.encodePacked("ENDED")))) {
            revert("Election has ended. ");
        }
        else if ((keccak256(abi.encodePacked(electionState)) == keccak256(abi.encodePacked("ONGOING")))) {
            revert("Election is already goin on. ");
        }
        else if ((keccak256(abi.encodePacked(electionState)) == keccak256(abi.encodePacked("NOT STARTED")))) {
            if ( owner == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4) {
            electionState = "ONGOING";
            }
        }
    }

    function vote(uint _ID, address _voter) public {
        if ((keccak256(abi.encodePacked(electionState)) == keccak256(abi.encodePacked("ONGOING")))) {
            if (voterMapping[_voter] == 0) {
                if (delegateMapping[_voter] == 0) {
                    revert("vote already casted or voter invalid. ");
                }
                else {
                    delegateMapping[_voter] = 0;
                    voteCount[_ID] ++;
                }
            }
            else {
                voterMapping[_voter] = 0;
                voteCount[_ID] ++;
            }     
        }
        else if ((keccak256(abi.encodePacked(electionState)) == keccak256(abi.encodePacked("NOT STARTED")))) {
            revert("Election not Started");
        }
        else if ((keccak256(abi.encodePacked(electionState)) == keccak256(abi.encodePacked("ENDED")))) {
            revert("Election Ended");
        }
    }




    function displayCandidate(uint _ID) view public returns(uint name, string memory, string memory) {
        candidateStruct storage candidate = candidateMapping[_ID];
        return (_ID, candidate.name, candidate.proposal);
    }

    function showResults(uint _ID) public view returns(uint, string memory, uint) {
        candidateStruct storage candidate = candidateMapping[_ID];
        return (_ID, candidate.name, voteCount[_ID]);
    }

    function showWinner() public view returns(string memory name, uint ID, uint Votes) {
        uint maxID = 0;
        uint maxVoteCount = 0;

        for (uint i = 1; i <= candidate_count; i ++) {
            if (voteCount[i] > maxVoteCount) {
                maxID = i;
                maxVoteCount = voteCount[i];
                
            }
        }

        return (candidateMapping[maxID].name, maxID, maxVoteCount);
    }
}
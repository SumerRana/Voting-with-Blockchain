a decentralized voting platform

This is a Solidity smart contract for an election. The contract includes functions to add candidates and voters, delegate votes, start and end the election, and vote for candidates. It also includes functions to display candidate information, show the results of the election, and show the winner.

The contract defines a struct called candidateStruct that stores the name and proposal of a candidate. It uses several mappings to keep track of the candidates, voters, delegates, and vote counts. The mappings candidateMapping and voteCount store information about the candidates and their vote counts. The mappings voterMapping and delegateMapping store information about the voters and their delegates.

The contract has a candidate_count variable to keep track of the number of candidates, a delegate_count variable to keep track of the number of delegates, and a voter_count variable to keep track of the number of voters.

The contract has a electionState variable to keep track of the state of the election. It can be "NOT STARTED", "ONGOING", or "ENDED".

The addCandidate function allows the contract owner to add candidates to the election. The addVoter function allows the contract owner to add voters to the election. The delegateVote function allows a voter to delegate their vote to another address. The endElection and startElection functions allow the contract owner to end and start the election respectively. The vote function allows a voter to cast a vote for a candidate.

The displayCandidate function allows anyone to view the name and proposal of a candidate. The showResults function allows anyone to view the vote count for a candidate. The showWinner function determines the candidate with the most votes and returns their name, ID, and vote count.

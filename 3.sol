pragma solidity ^0.6.12;

contract CharitableGiving {

    address public owner;

    mapping (address => uint256) public donations;

    mapping (address => uint256) public charityVotes;

    mapping (uint256 => address) public charities;

    mapping (uint256 => uint256) public charityDonations;

    uint256 public totalVotes;

    uint256 public totalCharities;

    uint256 public votingDeadline;

    uint256 public charitySelectionDeadline;

    bool public votingOpen;

    bool public charitySelectionOpen;

    Token public token;

    constructor(Token _token) public {

        owner = msg.sender;

        token = _token;

        votingOpen = true;

        charitySelectionOpen = false;

    }

    function addCharity(address _charity) public {

        require(msg.sender == owner, "Only the owner can add charities");

        charities[totalCharities] = _charity;

        totalCharities++;

    }

    function vote(uint256 _charityIndex) public payable {

        require(votingOpen, "Voting period has ended");

        require(_charityIndex < totalCharities, "Invalid charity index");

        require(msg.value >= token.minDonation(), "Transfer amount must be greater than or equal to the minimum donation amount");

        charityVotes[msg.sender] = _charityIndex;

        token.transfer(charities[_charityIndex], msg.value);

        totalVotes++;

    }

    function donate(address _charity) public payable {

        require(!charitySelectionOpen, "Charity selection period is currently active");

        require(msg.value >= token.minDonation(), "Transfer amount must be greater than or equal to the minimum donation amount");

        token.transfer(_charity, msg.value);

        donations[msg.sender] += msg.value;

    }

    function closeVoting() public {

        require(msg.sender == owner, "Only the owner can close voting");

        votingOpen = false;

        charitySelectionOpen = true;

    }

    function selectCharity() public {

        require(msg.sender == owner, "Only the owner can select the charity");

        uint256 selectedCharity = 0;

        uint256 selectedCharityVotes = 0;

        for (uint256 i = 0; i < totalCharities; i++) {

            if (charityVotes[i] > selectedCharityVotes) {

                selectedCharity = i;

                selectedCharityVotes = charityVotes[i];

            }

        }

        charityDonations[selectedCharity] += address(this).balance;

        charitySelectionOpen = false;

    }

    function setVotingDeadline(uint256 _deadline) public {

        require(msg.sender == owner, "Only the owner can set the voting deadline");

        votingDeadline = _deadline;

    }

        function setCharitySelectionDeadline(uint256 _deadline) public {

        require(msg.sender == owner, "Only the owner can set the charity selection deadline");

        charitySelectionDeadline = _deadline;

    }

    function getDonation(address _address) public view returns (uint256) {

        return donations[_address];

    }

    function getCharityVote(address _address) public view returns (uint256) {

        return charityVotes[_address];

    }

    function getCharity(uint256 _index) public view returns (address) {

        return charities[_index];

    }

    function getCharityDonation(uint256 _index) public view returns (uint256) {

        return charityDonations[_index];

    }

    function getVotingDeadline() public view returns (uint256) {

        return votingDeadline;

    }

    function getCharitySelectionDeadline() public view returns (uint256) {

        return charitySelectionDeadline;

    }

}



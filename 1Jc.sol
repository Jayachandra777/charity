pragma solidity ^0.8.0;

contract CharitableGiving {

    using SafeMath for uint256;

    

    const symbol cUSD = symbol(2, "cUSD");

    address owner;

    uint256 votingDeadline;

    uint256 charitySelectionDeadline;

    mapping(address => uint256) donations;

    mapping(address => uint256) charityVotes;

    address[] charities;

    uint256[] charityDonations;

    struct Charity {

        string name;

        string description;

    }

    mapping(address => Charity) charityInfo;

    function addCharity(string memory _name, string memory _description) public {

        require(msg.sender == owner, "Only the owner can add a charity");

        charities.push(msg.sender);

        charityInfo[msg.sender] = Charity(_name, _description);

    }

    function donate(uint256 _amount) public payable {

        require(msg.value == _amount, "The transfer amount must match the donation amount");

        donations[msg.sender] = donations[msg.sender].add(_amount);

    }

    function vote(address _charity, uint256 _amount) public payable {

        require(msg.value == _amount, "The transfer amount must match the vote amount");

        charityVotes[_charity] = charityVotes[_charity].add(_amount);

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

    function getCharityInfo(address _charity) public view returns (string memory, string memory) {

        return (charityInfo[_charity].name, charityInfo[_charity].description);

    }

}


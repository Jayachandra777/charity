pragma solidity ^0.8.0;

contract CharitableGiving {

    using SafeMath for uint256;

    

    const symbol cUSD = symbol(2, "cUSD");

    

    struct Charity {

        uint256 id;

        string name;

        uint256 goal;

        uint256 totalDonated;

    }

    

    mapping (uint256 => Charity) public charities;

    uint256[] public charityIds;

    uint256 public charitySelectionDeadline;

    

    event NewCharity(

        uint256 id,

        string name,

        uint256 goal

    );

    

    event CharityDonation(

        uint256 id,

        uint256 amount

    );

    

    function addCharity(string memory _name, uint256 _goal) public {

        uint256 id = charityIds.push(0) - 1;

        charities[id] = Charity(id, _name, _goal, 0);

        charityIds[id] = id;

        emit NewCharity(id, _name, _goal);

    }

    

    function donate(uint256 _id, uint256 _amount) public {

        Charity storage charity = charities[_id];

        charity.totalDonated = charity.totalDonated.add(_amount);

        emit CharityDonation(_id, _amount);

    }

    

    function setCharitySelectionDeadline(uint256 _timestamp) public {

        require(charitySelectionDeadline == 0, "Deadline has already been set");

        charitySelectionDeadline = _timestamp;

    }

}


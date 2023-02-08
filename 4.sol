

pragma solidity ^0.6.12;

import "github.com/celo-org/celo-contracts/contracts/StableToken.sol";

contract CharitableGiving {

    using SafeMath for uint256;

    

    StableToken public cUSD;

    

    struct Donation {

        address donor;

        uint256 amount;

        uint256 timestamp;

    }

    

    mapping (address => Donation) public donations;

    

    constructor(address cUSDAddress) public {

        cUSD = StableToken(cUSDAddress);

    }

    

    function donate(uint256 amount) public payable {

        require(msg.value >= amount, "Donation amount is greater than the sent amount.");

        

        donations[msg.sender].donor = msg.sender;

        donations[msg.sender].amount = donations[msg.sender].amount.add(amount);

        donations[msg.sender].timestamp = now;

    }

    

    function getDonationCount() public view returns (uint256) {

        return donations.length;

    }

    

    function getDonation(address donor) public view returns (uint256, uint256) {

        return (donations[donor].amount, donations[donor].timestamp);

    }

    

    function transferDonation(address recipient, uint256 amount) public {

        require(donations[msg.sender].amount >= amount, "Sender has insufficient funds.");

        

        donations[msg.sender].amount = donations[msg.sender].amount.sub(amount);

        cUSD.transfer(recipient, amount);

    }

}


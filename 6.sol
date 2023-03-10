// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract CharitableGiving {

    address public cUSDAddress = 0x765DE816845861e75A25fCA122bb6898B8B1282a;

    address public charityAddress;

    mapping(address => uint256) public donations;

    mapping(address => uint256[]) public scheduledDonations;

    uint256 public totalDonations;

    // Event to log donations

    event LogDonation(address donor, uint256 amount);

    // Function to allow users to donate tokens

    function donate(uint256 amount) public {

        require(address(this).balance >= amount, "Not enough balance");

        donations[msg.sender] += amount;

        totalDonations += amount;

        emit LogDonation(msg.sender, amount);

    }

    // Function to allow users to schedule future token transfers

    function scheduleDonation(uint256 amount, uint256 time) public {

        require(address(this).balance >= amount, "Not enough balance");

        require(time >= now, "Time must be in the future");

        scheduledDonations[msg.sender].push(amount);

        // Schedule transfer at specified time

        require(

            address(0x765DE816845861e75A25fCA122bb6898B8B1282a).transferFrom(

                address(this), charityAddress, amount, time

            ),

            "Transfer failed"

        );

    }

    // Function to allow the charity to receive donated tokens

    function receiveDonation() public payable {

        charityAddress = msg.sender;

    }

}


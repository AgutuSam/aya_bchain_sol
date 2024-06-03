// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BuyTickets {

    uint256 public constant TICKET_PRICE = 0.01 ether;

    struct Ticket {
        string name;
        uint256 numberOfTickets;
    }

    mapping(address => Ticket) public tickets;

	function buyTicket(string memory _name, uint256 _numberOfTickets) external payable {
		require(msg.value == _numberOfTickets * TICKET_PRICE, "Wrong Value");
		require(_numberOfTickets <= 10, "Maximum Limit Exceeded");
		require(tickets[msg.sender].numberOfTickets + _numberOfTickets <= 10, "Maximum Limit Reached");

		tickets[msg.sender].name = _name;
		tickets[msg.sender].numberOfTickets += _numberOfTickets;
	}

    function displayTicket(address _ticketHolder) external view returns (Ticket memory) {
        return(tickets[_ticketHolder]);
    }
}
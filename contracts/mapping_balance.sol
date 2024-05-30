// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/Strings.sol";

contract ERC20Token {
    address public banker = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    mapping(address => uint256) public balances;

    function setSomeonesBalance(address owner, uint256 amount) public {
        // require(msg.sender == banker,"Not the banker" );
        if(msg.sender == banker){
        balances[owner] = amount;
        }else{
        revert("Not the banker");
        }

        // If needs to go with an else statement, otherwise, it doesn't work!
        // Require on the other hand, works quite well!
    }

    function transferTokensBetweenAddresses(address sender, address receiver, uint256 amount) public {
        balances[sender] -= amount;   // deduct/debit the sender's balance
        balances[receiver] += amount; // credit the reciever's balance
    }

    function whoami() public view returns (address, address){
        address myAddress = msg.sender;
        address contractAddress = address(this);
        
        return(myAddress,contractAddress);
    }
}


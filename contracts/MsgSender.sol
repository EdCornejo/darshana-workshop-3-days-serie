// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

contract MsgSender {
    address caller;

    function setCaller() public returns (address) {
        caller = msg.sender;
        return msg.sender;
    }
}

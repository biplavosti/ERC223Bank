pragma solidity ^0.4.23;

interface ERC223Receiver {
    function erc223ReceiverFallBack(address _from, uint _value, bytes _data) external;
}
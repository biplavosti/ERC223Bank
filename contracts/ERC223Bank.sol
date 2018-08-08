pragma solidity ^0.4.23;

import "interface/ERC223Interface.sol";
import "interface/ERC223ReceiverInterface.sol";

contract ERC223Bank is ERC223Receiver {
    
    mapping(address => mapping(address => uint)) locker;
    
    function balance(address tokenAddress) public view returns (uint) {
        return (locker[msg.sender][tokenAddress]);
    }
    
    function deposit(address user, uint tokenCount) private {
        require(ERC223(msg.sender).balanceOf(user) >= tokenCount);
        
        locker[user][msg.sender] = tokenCount;
    }
    
    function withdraw(address tokenAddress, uint value) public {
        require(locker[msg.sender][tokenAddress] >= value);
        
		locker[msg.sender][tokenAddress] -= value;
        ERC223 token = ERC223(tokenAddress);
        token.transfer(msg.sender, value);
    }
    
    function ERC223ReceiverFallBack(address _from, uint _value, bytes _data) external {
        deposit(_from, _value);
    }
}
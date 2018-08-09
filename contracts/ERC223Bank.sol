pragma solidity ^0.4.23;

import "./interface/ERC223Interface.sol";
import "./interface/ERC223ReceiverInterface.sol";

contract ERC223Bank is ERC223Receiver {
    
	event Deposit(address user, address tokenAddress, uint tokens);
	event Withdraw(address user, address tokenAddress, uint tokens);
	
    mapping(address => mapping(address => uint)) locker;
    
    function balance(address tokenAddress) public view returns (uint) {
        return (locker[msg.sender][tokenAddress]);
    }
    
    function deposit(address user, uint value) private {
        require(ERC223(msg.sender).balanceOf(user) >= value);
        
		emit Deposit(user, msg.sender, value);
        locker[user][msg.sender] += value;
    }
    
    function withdraw(address tokenAddress, uint value) public {
        require(locker[msg.sender][tokenAddress] >= value);
        
		emit Withdraw(msg.sender, tokenAddress, value);
		locker[msg.sender][tokenAddress] -= value;
        ERC223(tokenAddress).transfer(msg.sender, value);
    }
    
    function ERC223ReceiverFallBack(address _from, uint _value, bytes _data) external {
        deposit(_from, _value);
    }
}
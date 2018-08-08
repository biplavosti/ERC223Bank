pragma solidity ^0.4.23;

interface ERC223 {
  function balanceOf(address who) external view returns (uint);
  function transfer(address to, uint value) external returns (bool ok);
  function transfer(address to, uint value, bytes data) external returns (bool ok);
  function transfer(address to, uint value, bytes data, string custom_fallback) external returns (bool ok);
  
  event Transfer(address indexed from, address indexed to, uint value, bytes indexed data);
}

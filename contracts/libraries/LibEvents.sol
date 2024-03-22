// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;


library LibEvents {
   event  DepositAmount(address indexed sender,address indexed _receiver, uint amount);
   event SumbitTransaction(address indexed sender,address indexed _reieiver ,uint _amount);
}
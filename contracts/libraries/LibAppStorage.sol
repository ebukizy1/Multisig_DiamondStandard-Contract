// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

library LibAppStorage {

   struct Transaction {
        uint256 id;
        uint256 amount;
        address receiver;
        uint256 signersCount;
        bool isExecuted;
        address txCreator;
        uint256 timeIntiated;
        uint256 timeExcuted;
    }

    struct Layout{
        //multi signature
        address [] signers;
        uint numberOfSigners;
        uint transactionId;
        mapping(uint => Transaction) transactions;
        mapping(uint => mapping(address => bool)) hasSigner;
        Transaction [] transactionList;


    }


    
}
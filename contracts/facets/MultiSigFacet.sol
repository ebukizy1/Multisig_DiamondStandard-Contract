// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

import {LibAppStorage} from "../libraries/LibAppStorage.sol";
import {LibError} from "../libraries/LibError.sol";
contract MultiSigFacet{
    LibAppStorage.Layout internal _appStorage;


    function submitTransaction(address _reieiver, uint256 _amount) external {
        if(_amount <= 0) revert LibError.INVALID_AMOUNT();
        uint _tranId = _appStorage.transactionId + 1;
        LibAppStorage.Transaction storage _transaction = _appStorage.transactions[_tranId];
        _transaction.id = _tranId;
        _transaction.receiver = _reieiver;
        _transaction.txCreator = msg.sender;
        _transaction.timeIntiated = block.timestamp;
        _transaction.amount = _amount;
        _transaction.signersCount = _transaction.signersCount + 1;

        _appStorage.transactionList.push(_transaction);
        _appStorage.transactionId += 1;
        
        _appStorage.hasSigned[_txId][msg.sender] = true;

        emit SumbitTransaction(msg.sender, _reieiver , _amount);

    }

    function approveTransaction(uint _txId) external{
        if(_txId > _appStorage.transactionId) revert LibError.INVALID_TRANSACTION_ID();
        if(!_appStorage.hasSigned[msg,sender]) revert LibError.ALREADY_SIGNED();
        

    }



    





}
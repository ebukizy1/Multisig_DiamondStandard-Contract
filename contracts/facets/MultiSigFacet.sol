// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

import {LibAppStorage} from "../libraries/LibAppStorage.sol";
import {LibError} from "../libraries/LibError.sol";
import {LibEvents} from "../libraries/LibEvents.sol";
contract MultiSigFacet{
    LibAppStorage.Layout internal _appStorage;


    function submitTransaction(address _reieiver, uint256 _amount) external {
        
        onlyValidSigner();

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

        emit LibEvents.SumbitTransaction(msg.sender, _reieiver , _amount);

    }

    function approveTransaction(uint _txId) external{
        onlyValidSigner();

        if(_txId > _appStorage.transactionId) revert LibError.INVALID_TRANSACTION_ID();
        if(_appStorage.hasSigned[msg.sender]) revert LibError.ALREADY_SIGNED();
        LibAppStorage.Transaction storage _foundTransaction _appStorage.transactions[_txId];
        if(_foundTransaction.signersCount < _appStorage.numberOfSigners) revert LibError.SIGNERS_NOT_REACH();
        if(_foundTransaction.isExecuted) revert LibError.TRANSACTION_ALREADY_EXECUTED();

        _foundTransaction.signersCount += 1;
        _appStorage.hasSigned[msg.sender] = true;
        if(_foundTransaction.signersCount == _appStorage.numberOfSigners){
            _foundTransaction.isExecuted = true; 
            _foundTransaction.timeExcuted = block.timestamp;
        }
        emit LibEvents.TransactionApproval(msg.sender, _txId );
    }

     function onlyValidSigner() private view {
        if(!_appStorage.isValidSigner[msg.sender]) revert LibError.NOT_VALID_SIGNER();
    }

      function addValidSigner(address _newSigner) external {
        require(!isValidSigner[_newSigner], "signer already exist");

        isValidSigner[_newSigner] = true;
        signers.push(_newSigner);
    }

    function getAllTransactions() external view returns (Transaction[] memory) {
        return allTransactions;
    }





    





}
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

import {LibAppStorage} from "../libraries/LibAppStorage.sol";
import "../libraries/LibError.sol";
contract MultiSigFacet{
    using LibError for *; 
    LibAppStorage.Layout internal _appStorage;


    function submitTransaction(address _reieiver, uint256 _amount) external {
        if(_amount <= 0) revert LibError.INVALID_AMOUNT();
        uint _tranId = _appStorage.transactionId + 1;
        LibAppStorage.Transaction storage _transaction = _appStorage.transactions[_tranId];
        _transaction.id = _tranId;
        _transaction.receiver = _reieiver;
        _transaction.txCreator = msg.sender;
        _transaction.timeIntiated = block.timestamp;
        _transaction.
    

    }





}
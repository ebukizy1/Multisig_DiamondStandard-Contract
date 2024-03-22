// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

import {LibError} from "../libraries/LibError.sol";    // using LibError for *;
import {LibAppStorage} from "../libraries/LibAppStorage.sol";
import {LibEvents} from "../libraries/LibEvents.sol";


contract VaultSystemFacet{
    LibAppStorage.Layout internal _appStorage;
        

    function depositIntoVault(_amount) external{

        if(_amount <= 0) revert LibError.INVALID_AMOUNT();
        if(_appStorage.balanceOf(msg.sender) <_amount) revert LibError.INSUFFICIENT_FUNDS();
        LibAppStorage._transferFrom(msg.sender, address(this), _amount);
        LibAppStorage.Vault storage _lockedDetails = _appStorage.lockedDetails[msg.sender]; 
        _lockedDetails.amount = _amount;
        _lockedDetails.depositedTime = block.timestamp;

        emit LibEvents.DepositAmount(msg.sender, address(this), _lockedDetails.amount);
        
    }

    function withdrawFromVault(uint id, uint _amount) external {
        if(!_appStorage.hasSigned[msg.sender])revert  LibError.NOT_AUTHORIZED();

            
    }
    
    
    




    
}
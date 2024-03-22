// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

library LibAppStorage {

   event Transfer(address indexed _from,address indexed _to, uint _amount);

   struct Vault {
        uint amount;
        uint depositedTime;
   }


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
        //erc20 token
        string name;
        string symbol;
        uint256 totalSupply;
        uint8 decimals;
        mapping(address => uint256) balances;
        mapping(address => mapping(address => uint256)) allowances;

        //multi signature
        address [] signers;
        uint numberOfSigners;
        uint transactionId;
        mapping(uint => Transaction) transactions;
        mapping(uint => mapping(address => bool)) hasSigned;
        Transaction [] transactionList;
        // vault facet
        mapping(address => Vault) lockedDetails;




    }




    function layoutStorage() internal pure returns (Layout storage l) {
        assembly {
            l.slot := 0
        }
    }

    function _transferFrom(address _from,address _to,uint256 _amount) internal {
        Layout storage l = layoutStorage();
        uint256 frombalances = l.balances[msg.sender];
        require(
            frombalances >= _amount,
            "ERC20: Not enough tokens to transfer"
        );
        l.balances[_from] = frombalances - _amount;
        l.balances[_to] += _amount;
        emit Transfer(_from, _to, _amount);
    }


    
}
pragma solidity ^0.4.4;

import './mortal.sol';

contract SimpleWallet is mortal {
    
    mapping(address => Permission) permittedAdresses;
    
    event someoneAddedSomeoneToSendersList (address thePersonWhoAdded, address thePersonWhoIsAllowedNow, uint thisMuchHeCanSend);
    
    struct Permission {
        bool isAllowed;
        uint maxTransferAmount;
    }

    function addAddressToSendersList (
            address permited, 
            uint maxTransferAmount
        ) onlyOwner {
        permittedAdresses[permited] = Permission(true, maxTransferAmount);
        someoneAddedSomeoneToSendersList(msg.sender, permited, maxTransferAmount);
    }
    

    function sendFunds (address receiver, uint amountInWei) {
        if(permittedAdresses[msg.sender].isAllowed){
            if(permittedAdresses[msg.sender].maxTransferAmount >= amountInWei){
                bool isTheAmountReallySent = receiver.send(amountInWei);
                if(!isTheAmountReallySent) {
                    throw;
                }
            }else{
                throw;
            }
        }else{
            throw;
        }
    }
    
    
    function removeAdressFromSendersList (address theAddress) {
        delete permittedAdresses[theAddress];
    }
    
    
    function () payable {
        
    }
}

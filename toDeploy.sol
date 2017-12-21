pragma solidity ^0.4.0;

contract owned {
    address owner;

    modifier onlyowner() {
        if (msg.sender == owner) {
            _;
        }
    }

    function owned() public {
        owner = msg.sender;
    }
}

contract mortal is owned {
    function kill() public {
        if (msg.sender == owner)
            selfdestruct(owner);
    }
}

contract SimpleWallet is mortal {
    
    mapping(address => Permission) permittedAddresses;
    
    event someoneAddedSomeoneToTheSendersList(address thePersonWhoAdded, address thePersonWhoIsAllowedNow, uint thisMuchHeCanSend);
  
    struct Permission {
        bool isAllowed;
        uint maxTransferAmount;
    }
    
    function addAddressToSendersList(address permitted, uint maxTransferAmount) onlyowner public {
        permittedAddresses[permitted] = Permission(true, maxTransferAmount);
        someoneAddedSomeoneToTheSendersList(msg.sender, permitted, maxTransferAmount);
    }
    
    function sendFunds(address receiver, uint amountInWei) public {
        if(permittedAddresses[msg.sender].isAllowed) {
            if(permittedAddresses[msg.sender].maxTransferAmount >= amountInWei) {
                bool isTheAmountReallySent = receiver.send(amountInWei);
                if(!isTheAmountReallySent) {
                    revert();
                }
            } else {
                revert();
            }
        } else {
            revert();
        }
    }
    
    function removeAddressFromSendersList(address theAddress) public {
        delete permittedAddresses[theAddress];
    }

    
    function () payable public {
        
    }
    
}
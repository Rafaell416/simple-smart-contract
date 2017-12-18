pragma solidity ^0.4.4;

contract MyContract {
    
    uint myVariable;
    
    address owner;
    
    modifier onlyOwner () {
        if(msg.sender == owner){
            _;
        }else{
            throw;
        }
    }
    
    function MyContract () payable {
        myVariable = 5;
        owner = msg.sender;
    }
    
    function setMyVariable (uint myNewVariable) onlyOwner {
        myVariable = myNewVariable;
    }
    
    function getMyVariable() constant returns(uint) {
        return myVariable;
    }
    
    function getMyContractBalance() constant returns (uint) {
        return this.balance;
    }
    
    function kill () onlyOwner {
        suicide(owner);
    }
    
    function () payable {
        
    }
}

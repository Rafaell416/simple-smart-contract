pragma solidity ^0.4.4;


contract mortal {
    address owner;
    
     modifier onlyOwner () {
        if(msg.sender == owner){
            _;
        }else{
            throw;
        }
    }
    
    function mortal () {
        owner = msg.sender;
    }
    
    function kill () onlyOwner {
         suicide(owner);
    }
}



contract MyContract is mortal {
    
    uint myVariable;

    
    function MyContract () payable {
        myVariable = 5;
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
    
    function () payable {
        
    }
}

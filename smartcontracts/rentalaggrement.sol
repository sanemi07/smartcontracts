// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;
contract rental{
  address payable manager;
  address payable renter;
  uint public  securitydepsit;
  uint public duedate;
  uint public rent;
  uint public paymentinterval;
  uint public latefine;
  uint public refund;
  constructor(address payable _renter, uint _rentAmount, uint _paymentInterval, uint _lateFine,uint s) {
        manager = payable(msg.sender); // The deployer of the contract is the manager
        renter = _renter;
        rent = _rentAmount;
        paymentinterval = _paymentInterval;
        latefine = _lateFine;
        duedate = block.timestamp + _paymentInterval; // Initial due date
        securitydepsit=s;
    }

  
  
    function transferdepo() public payable {
      require(msg.sender==renter);
      require(msg.value==securitydepsit);
      manager.transfer(msg.value);
     



    }
   
    function monthly() payable public {
      require(msg.sender==renter);
      uint rentdue=rent;
      if(block.timestamp>duedate){
        rentdue+=latefine;
      }
      require(msg.value==rentdue);
      manager.transfer(rentdue);
      duedate+=paymentinterval;
      
      



    }
    function returndepo(uint _refund) public payable {
      require(msg.sender==manager);
      refund=_refund;
      renter.transfer(refund);


    }

}
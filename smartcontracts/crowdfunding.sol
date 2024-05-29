//SPDX-License-Identifier: GPL 3.0
pragma solidity 0.8.25;
contract crowdfunding{
mapping(address=>uint) public contributor;
address public manager;
uint public deadline;
uint public minimumamount;
uint public totalraised;
uint public totalcontributor;
uint public target;

event managerwithdraw (uint _value) ;
event funded(address _funder,uint _value);
event funderwithdraw(address _funder,uint _value);

constructor(uint _deadline,uint _target) 
{
    manager=msg.sender;
    deadline=block.timestamp+_deadline;
    minimumamount=100 wei;
    target=_target;

}
 function isfundedenabled()  public view returns(bool) {
    if(block.timestamp>deadline){
        return true;
    }
    else{
        return false;
    }}

  function isfundsuccess() public view returns (bool){
    if(address(this).balance>=target){
        return true;
    }else{
        return false;
    }
  }  



  function fundtransfer() public payable {
    require(isfundedenabled());
    require(msg.value>=minimumamount);
    contributor[msg.sender]+=msg.value;
    emit funded(msg.sender,msg.value);
  }
  
  function ownerwithdraw() public {
    require(isfundsuccess());
    require(msg.sender==manager);
    uint amounttransfer=address(this).balance;
    payable(manager).transfer(amounttransfer);
    emit managerwithdraw(amounttransfer);

   

  }function contransfer() public payable {
    require(!isfundsuccess(), "Fundraise was successful, contributors cannot withdraw");
    require(contributor[msg.sender] > 0, "You have no funds to withdraw");

    uint amountTransfer = contributor[msg.sender];
    contributor[msg.sender] = 0; // Reset the contributor's balance to prevent re-entrancy
    payable(msg.sender).transfer(amountTransfer);
    emit funderwithdraw(msg.sender, amountTransfer);
}

  


 }





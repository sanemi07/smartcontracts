// SPDX-License-Identifier: GPL 3.0
pragma solidity 0.8.25;
contract events{
    
    struct devent{
        address organiser;
        string name;
        uint date;
        uint price;
        uint totalticket;
        uint remainingticket;
    }
    mapping(uint=>devent) public devents ;
    mapping(address=>mapping (uint=>uint)) public tickets;
    uint public nextid;

    function createevent(string memory name,uint price,uint date,uint totalticket) external {
        require(date>block.timestamp,"event is expired");
        require(totalticket>0);
        devents[nextid]=devent(msg.sender,name,date,price,totalticket,totalticket);
        nextid++;



    }
    function buyticket(uint id,uint quantity) payable external {
       require(devents[id].date!=0,"event not exists");
        require(devents[id].date>block.timestamp,"event has ended");
        require(devents[id].price*quantity==msg.value);
        require(devents[id].remainingticket>quantity);
        devents[id].remainingticket-=quantity;
        tickets[msg.sender][id]+=quantity;

    }
    function transferticket(uint id,uint quantity,address to) external{
     require(devents[id].date!=0,"event not exists");
        require(devents[id].date>block.timestamp,"event has ended");
        require(tickets[msg.sender][id]>=quantity,"not enough ticket");
        tickets[msg.sender][id]-=quantity;
        tickets[to][id]+=quantity;
    }



}


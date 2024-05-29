//SPDX-License-Identifier: GPL 3.0
pragma solidity 0.8.25;

contract lottery{
    address public manager;
    address payable [] public players;

    constructor()
{        manager=msg.sender;}

receive() external payable { 
    require(msg.value>=3 ether);
    address payable player = payable(msg.sender);
players.push(player);
    
}
function getbalance() public view returns (uint){
    require(msg.sender==manager);
    return address(this).balance;

}
function random() public view returns(uint){
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));

   
}
function selectwinner() public{
    require(msg.sender==manager);
    require(players.length>=3);
    uint r=random();
    uint index=r%players.length;
     address payable winner=players[index];
    winner.transfer(getbalance());
    players=new address payable [](0);
   

    
    
}
    

    
} 
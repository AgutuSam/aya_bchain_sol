// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StructCRUD{

struct Item{
    string name;
    string age;
    uint256 id;
    bool verrification;
}

Item[] public items;
uint256 public nextID = 1;
uint256[] public availableID;

function create(string memory _name, string memory _age) public {
    if(availableID.length > 0){
        items.push(Item(_name, _age, availableID[availableID.length - 1], true));
        availableID.pop();
    }else{
        items.push(Item(_name, _age, nextID, true));
        nextID++;
    }
    
}

function findID(uint256 querryID) view public returns(uint256){

    for (uint256 i =0; i<= items.length; i++) 
    {
      if(items[i].id == querryID) {
        return i;
      } 
    }
}

function update(string memory _name, string memory _age, uint256 _id) public {
    uint256 i = findID(_id);
   items[i].name = _name;
   items[i].age = _age;
}

function remove(uint256 _id) public{
 uint256 i = findID(_id);
 items[i] = items[items.length -1];
 availableID.push(_id);
 items.pop();
}
}
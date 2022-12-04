// SPDX - License - Identifier: MIT

/*
Agenda:
    Make a vender machine for donut so that peoples can purchase donut by spending eths and only manager have the 
    rights to restock and check balance in vending machine
*/

pragma solidity ^0.8.17;

contract Vending
{
    // state variable 
    address public manager;
    mapping (address => uint) public donutBalance;

    constructor()
    {
        manager = msg.sender;
        donutBalance[address(this)] = 100;
    }

    function getBalanceOfVendingMachine() public view returns(uint)
    {
        return donutBalance[address(this)];
    }

    // Restock the vending machine by manager
    function restock(uint amount) public
    {
        require(msg.sender == manager, "You are not able to restock");
        donutBalance[address(this)] += amount;
    }

    // Purchase donut from vending machine, where minimum donut costing is 1 eth
    function purchaseDonut(uint quantiy) public payable
    {
        require(msg.value >= quantiy * 2 ether, "You must pay atleast 2 ETH per donut");
        require(donutBalance[address(this)] >= quantiy, "We don't have enough donuts");
        donutBalance[address(this)] -= quantiy;
        donutBalance[msg.sender] += quantiy;

    }
}
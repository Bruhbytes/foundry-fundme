// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint256;
    uint public constant minimumUSD = 50 * 1e18;
    address public immutable owner;
    address public priceFeed;

    address[] public funders;
    mapping (address => uint256) public addressToAmount;
    
    constructor(address pf){
        owner = msg.sender;        
        priceFeed = pf;
    }


    function fund() public payable {
        require(msg.value.getConversionRate(priceFeed) >= minimumUSD, "Give greater than 50$");
        funders.push(msg.sender);
        addressToAmount[msg.sender] = msg.value;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

    function withdraw() public onlyOwner{
        for(uint i = 0; i < funders.length; i++){
            addressToAmount[funders[i]] = 0;
        }
        funders = new address[](0);

        //actual withdrawal
        (bool sent,) = payable(msg.sender).call{value: address(this).balance}("");
        require(sent, "wasnt able to send ether");
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Sender is not the owner");
        _;
    }

}
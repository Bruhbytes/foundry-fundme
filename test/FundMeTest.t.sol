// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.sol";

contract FundmeTest is Test{
    FundMe fundme;
    address USER = makeAddr("dts");

    function setUp() external{
        DeployFundMe deploy = new DeployFundMe();
        fundme = deploy.run();
        // fundme = new FundMe(); 

        vm.deal(USER, 10 ether);
    }

    function test_MinimumDollarsFifty() view public{
        assertEq(fundme.minimumUSD(), 50 * 1e18);        
    }

    function test_ownerIsMsgSender() view public{
        console.log(fundme.owner());
        console.log(msg.sender);
        console.log(address(this));
        assertEq(fundme.owner(), msg.sender);
        // assertEq(fundme.owner(), address(this)); 
        // used when fundme is deployed directly without the script by FundMeTest contract                            
    }

    function test_revertIfAmountLessThenMinimumUSD() public{
        vm.expectRevert();
        fundme.fund{value: 0}();
    }

    function test_checkFundersListForSender() public{        
        vm.prank(USER);
        fundme.fund{value: 1e18}();

        uint amountFunded = fundme.addressToAmount(USER);
        assertEq(amountFunded, 1e18);
    }

    function test_addsFunderToArray() public{
        fundme.fund{value: 1e18}();

        address sender = fundme.funders(0);
        assertEq(sender, address(this));
    }

    function test_withdrawFailingForDummyUSER() public{
        vm.prank(USER);
        fundme.fund{value: 1 ether}();

        vm.prank(USER);
        vm.expectRevert();
        fundme.withdraw();
    }
    
    function test_withdrawWithUsingSingleFunder() public{
        fundme.fund{value: 1 ether}();

        uint startOwnerBalance = fundme.owner().balance;
        uint startFundMeContractBalance = address(fundme).balance;
        
        vm.prank(msg.sender);
        fundme.withdraw();        
        
        uint endOwnerBalance = fundme.owner().balance;
        uint endFundmeContractBalance = address(fundme).balance;
        assertEq(endFundmeContractBalance, 0);        
        assertEq(startFundMeContractBalance + startOwnerBalance, endOwnerBalance);
    }
}
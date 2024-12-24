// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";


contract FundFundme is Script{
    function run() external{
        address recentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fund_fundme(recentlyDeployed);
        vm.stopBroadcast();
    }

    function fund_fundme(address deployed) public{
        // Create an instance of the FundMe contract with the deployed address, ensuring it's payable
        FundMe(payable(deployed)).fund{value: 0.1 ether}();
        console.log("Funded Fundme with 0.01");
    }
}

contract WithdrawFundme is Script{
    function run() external{
        address recentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        withdraw_fundme(recentlyDeployed);
        vm.stopBroadcast();
    }

    function withdraw_fundme(address deployed) public{
        FundMe(payable(deployed)).withdraw();
        console.log("Withdraw the fundme contract");
    }
}
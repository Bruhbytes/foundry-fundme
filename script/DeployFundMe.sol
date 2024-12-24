// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "../script/HelperConfig.s.sol";

contract DeployFundMe is Script{
    function run() external returns(FundMe){
        HelperConfig helper = new HelperConfig();
        address pricefeed = helper.activeNetworkConfig();
        console.log("pricefeed address: ", pricefeed);

        vm.startBroadcast();
        FundMe fund = new FundMe(pricefeed);
        vm.stopBroadcast();
        return fund;
    }
}
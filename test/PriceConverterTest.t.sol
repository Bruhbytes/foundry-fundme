// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {PriceConverter} from "../src/PriceConverter.sol";
import {HelperConfig} from "../script/HelperConfig.s.sol";

contract PriceConverterTest is Test{
    // PriceConverter pc;
    // function setUp() external{
    //     pc = new PriceConverter();
    // }

    function test_getversion() public{
        HelperConfig helper = new HelperConfig();  
        uint version = 4;
        if(block.chainid == 1){ version = 6; }
        assertEq(PriceConverter.getVersion(helper.activeNetworkConfig()), version);
    }
}
// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script{
    //if we are on local ganache, we deploy mocks
    //otherwise, grab the existing address from the live network
    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        address priceFeed;        
    }

    constructor(){
        if(block.chainid == 11155111){
            activeNetworkConfig = getSepoliaConfig();
        }
        else if(block.chainid == 1){
            activeNetworkConfig = getMainnetConfig();            
        }
        else{
            activeNetworkConfig = getLocalConfig();
        }
    }

    function getSepoliaConfig() public pure returns(NetworkConfig memory){
        NetworkConfig memory sepoliaConfig = NetworkConfig(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        return sepoliaConfig;
    }

    function getMainnetConfig() public pure returns(NetworkConfig memory){
        NetworkConfig memory ethConfig = NetworkConfig({
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
        return ethConfig;
    }

    function getLocalConfig() public returns(NetworkConfig memory){
        //mock contract address
        vm.startBroadcast();
        MockV3Aggregator mockContract = new MockV3Aggregator(3000e8, 8);
        vm.stopBroadcast();

        NetworkConfig memory localConfig = NetworkConfig(address(mockContract));
        return localConfig;
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function getPrice(address pf) internal view returns(uint){
        AggregatorV3Interface pricefeed = AggregatorV3Interface(pf);
        (, int answer, , , ) = pricefeed.latestRoundData();
        return uint(answer);
    }

    function getConversionRate(uint256 ethAmount, address priceFeedAddr) internal view returns(uint256){        
        uint dec = 18 - getDecimals(priceFeedAddr); //dec = 10
        uint ethPrice = getPrice(priceFeedAddr) * uint(10**dec);

        return (ethAmount * ethPrice) / 1e18;
    }

    function getVersion(address pf) internal view returns(uint){        
        AggregatorV3Interface pricefeed = AggregatorV3Interface(pf);
        return pricefeed.version();
    }

    function getDecimals(address pf) internal view returns(uint){
        AggregatorV3Interface pricefeed = AggregatorV3Interface(pf);
        return pricefeed.decimals();
    }
}
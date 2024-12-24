// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract MockV3Aggregator {
    int256 private price;
    uint8 private deci;

    constructor(int256 _initialPrice, uint8 _decimals) {
        price = _initialPrice;
        deci = _decimals;
    }

    function setPrice(int256 _price) external {
        price = _price;
    }

    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
        return (0, price, 0, block.timestamp, 0);
    }

    function decimals() external view returns (uint8) {
        return deci;
    }

    function version() external pure returns(uint){
        return 4;
    }
}

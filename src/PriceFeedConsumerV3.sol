// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./IAggregatorV3.sol";

contract PriveFeedConsumerV3 {
    address constant ETH_VS_USD_FEED_ADDRESS = 0x0715A7794a1dc8e42615F059dD6e406A6594651A ;

    AggregatorV3Interface internal priceFeed;

    /**
     * @notice Network: polygon
     *         Aggregator: BTC/USD
     *         Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     */
    constructor() {
        // priceFeed = AggregatorV3Interface(ETH_VS_USD_FEED_ADDRESS);
        setPriceFeed(ETH_VS_USD_FEED_ADDRESS);
    }

    /**
     * @dev set `priceFeed` aggregator to fetch data from `address`
     */
    function setPriceFeed(address _address) public {
        priceFeed = AggregatorV3Interface(_address);
    }

    /**
     * @dev Returns the latest price.
     */
    function getLatestPrice() public view returns (int) {
        (
            ,// uint80 roundID,
            int price,
            ,// uint startedAt,
            ,// uint timeStamp,
             // uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        return price;
    }

    /**
     * Returns historical price for a round id.
     * roundId is NOT incremental. Not all roundIds are valid.
     * You must know a valid roundId before consuming historical data.
     *
     * ROUNDID VALUES:
     *    InValid:      18446744073709562300
     *    Valid:        18446744073709554683
     *
     * @dev A timestamp with zero value means the round is not complete and should not be used.
     */
    function getHistoricalPrice(uint80 roundId) public view returns (int256) {
        (
            uint80 roundID,
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeed.getRoundData(roundId);
        require(timeStamp > 0, "Round not complete");
        return price;
    }

}

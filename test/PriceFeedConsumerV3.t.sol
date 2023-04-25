// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol" ;
import "../src/PriceFeedConsumerV3.sol" ;
import "./TestUtil.t.sol" ;

contract PriceFeedConsumerV3Test is Test , TestUtil {
    address constant POLYGON_LINK_TOKEN_ADDRESS = 0xb0897686c545045aFc77CF20eC7A532E3120E0F1 ;

    PriveFeedConsumerV3 testContract ;

    function setUp() public {
        uint256 polygonFork = vm.createFork(vm.rpcUrl("polygon")) ;
        vm.selectFork(polygonFork) ;
        testContract = new PriveFeedConsumerV3() ;
    }

    function test_GetPrice() public {
        deal(POLYGON_LINK_TOKEN_ADDRESS,address(this),1_000_000_000_000);
        int256 price = testContract.getLatestPrice() ;
    }

}

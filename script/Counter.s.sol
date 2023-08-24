// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "src/FFFactory.sol";
contract CounterScript is Script {
    FFFactory factory;
    FundFlowContract child;
    function setUp() public {}

    function run() public {
         uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
            factory = new FFFactory();
            child = new FundFlowContract(0xe78Fc55c884704F9485EDa042fb91BfE16fD55c1);
    }
}

// forge verify-contract \
//     --chain-id 84531 \
//     --num-of-optimizations 1000000 \
//     --watch \
//     --etherscan-api-key V31R324BWIZN1CZXXBXCS4VTEAXMXZHM65 \
//     --compiler-version v0.8.17+commit.8df45f5f \
//     0x0a700Ac39252CF75a5D3be44D59c19d7911aeDA9 \
//     src/FFFactory.sol:FFFactory 
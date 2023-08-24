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

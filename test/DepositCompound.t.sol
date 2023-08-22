// SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/FundFlowContract.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";


contract DepositCompound is Test{
    using SafeERC20 for IERC20; 
    FundFlowContract public fund;
    Icompound compound;

 address owner = 0x748dE14197922c4Ae258c7939C7739f3ff1db573;
 address USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
 address compoundAddress = 0xc3d688B66703497DAA19211EEdff47f25384cdc3;
 address USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;   
 address LINK = 0x514910771AF9Ca656af840dff83E8264EcF986CA;   
 address COMP = 0xc00e94Cb662C3520282E6f5717214004A7f26888;   
 address UNI = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984;   
     address weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
//  address asset =
function setUp() public{
    vm.startPrank(owner);
    uint mainnet = vm.createFork("https://eth-mainnet.g.alchemy.com/v2/xypdsCZYrlk6oNi93UmpUzKE9kmxHy2n", 17042314);
    vm.selectFork(mainnet);
    fund = new FundFlowContract(compoundAddress);
}

function testDeposit() public{
    // vm.startPrank(owner);
    console.log("Owner balance before Coin deposit:", IERC20(UNI).balanceOf(owner));
    IERC20(UNI).safeApprove(address(fund), 1000 * 1e18); 
    fund.deposit(UNI, 10 * 1e18);
    console.log("Owner balance After Coin deposit:", IERC20(UNI).balanceOf(owner));
  
}


function testDepositCompound() public{
    testDeposit();
    console.log("contract balance before Coin deposit:", IERC20(UNI).balanceOf(address(fund)));
    fund.depositCompound( UNI, 1* 1e18);
    console.log("contract balance After Coin deposit:", IERC20(UNI).balanceOf(address(fund)));
    // vm.stopPrank();
}

// function testWithdrawCompound() public{
//     testDepositCompound();
//     fund.withdrawCompound(LINK, 9 * 1e18);
//     console.log("contract balance after withdraw:", IERC20(LINK).balanceOf(address(fund)));
//     // vm.stopPrank();
// }

function testBorrow() public {
    testDepositCompound();
     IERC20(UNI).safeApprove(address(fund), 1000 * 1e18); 
fund.buyCollateral(USDC, 1, 1, address(fund));
//  fund.borrow(USDC, 1 );

}

}
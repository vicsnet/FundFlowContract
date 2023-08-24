// SPDX-License-Identifier:MIT

pragma solidity ^0.8.17;

import {IRouter} from "./interface/IRouter.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

contract fundFlowContract {
    IRouter router;

    constructor(address _router) {
        router = IRouter(_router);
    }

    function addLiquidity(
        address _tokenA,
        address _tokenB,
        uint256 _amountADesired,
        uint256 _amountBDesired,
        uint256 _amountAMin,
        uint256 _amountBMin,
        address _to
    ) public returns (uint256 amountA, uint256 amountB,uint256 liquidity){
        
        router.addLiquidity(
            _tokenA,
            _tokenB,
            _amountADesired,
            _amountBDesired,
            _amountAMin,
            _amountBMin,
            _to
        );
        
        return (amountA, amountB, liquidity); 
        
    }


    function removeLiquidity(
        address _tokenA,
        address _tokenB,
        uint256 _liquidity,
        uint256 _amountAMin,
        uint256 _amountBMin,
        address _to
    ) public returns (uint256 amountA, uint256 amountB) {

        // Call Uniswap's removeLiquidity function
        router.removeLiquidity(
            _tokenA,
            _tokenB,
            _liquidity,
            _amountAMin,
            _amountBMin,
            _to
    );

    return (amountA, amountB);
        

    }

    function swapExactTokensForTokens(
        uint256 _amountIn,
        uint256 _amountOutMin,
        address[] calldata _path,
        address _to
    ) public returns (uint256[] memory _amounts){
        router.swapExactTokensForTokens( _amountIn, _amountOutMin, _path, _to );
        return _amounts;
    }   


    function swapTokensForExactTokens(
        uint256 _amountOut,
        uint256 _amountInMax,
        address[] calldata _path,
        address _to
    ) public returns (uint256[] memory amounts){
        router.swapTokensForExactTokens(_amountOut, _amountInMax, _path, _to);
        return amounts;
    }







}

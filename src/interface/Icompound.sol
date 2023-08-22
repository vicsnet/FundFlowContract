// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface Icompound{

function supply(address asset, uint amount) external;

function supplyTo(address dst, address asset, uint amount) external;

function supplyFrom(address from, address dst, address asset, uint amount) external;
function withdraw(address asset, uint amount) external;

function withdrawTo(address to, address asset, uint amount) external;

function withdrawFrom(address src, address to, address asset, uint amount) external;
function balanceOf(address owner) external view returns (uint256 balance);
function baseBorrowMin() external view returns (uint256);
function isBorrowCollateralized(address account) external view returns (bool);
function borrow(uint borrowAmount) external returns (uint);

}

interface IERC20{
 function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function decimals() external returns (uint);
}
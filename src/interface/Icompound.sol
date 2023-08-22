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
	function buyCollateral(
		address asset,
		uint256 minAmount,
		uint256 baseAmount,
		address recipient
	) external virtual;
}


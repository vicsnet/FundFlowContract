// SPDX-License-Identifier:MIT

pragma solidity ^0.8.17;
import {Icompound} from "./interface/Icompound.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

contract FundFlowContract {
    using SafeERC20 for IERC20;
    Icompound compound;

    constructor(address _compound) {
        compound = Icompound(_compound);
    }
    struct RewardOwed {
    address token;
    uint owed;
    }   

    /**
     *_tokenTYPE : address of the token to deposit
     *_amount: amount to deposit
     */
    function deposit(address _tokenTYPE, uint _amount) public {
        IERC20(_tokenTYPE).safeTransferFrom(msg.sender, address(this), _amount);
    }
    function depositCollateral(address _tokenTYPE, uint _amount) public {
       
        IERC20(_tokenTYPE).transferFrom(msg.sender, address(this), _amount);
    }

    /**
    withdaw from smart contract
 */
    function withdraw(address _tokenTYPE, uint _amount) public {
        uint _balance = IERC20(_tokenTYPE).balanceOf(address(this));
        require(_amount <= _balance, "Insufficient balance");
        IERC20(_tokenTYPE).safeTransfer(msg.sender, _amount);
    }

    /**
     *@dev supply token to compound
     * from: Adrdess of the sender
     * dst Address of the contract calling the function
     * asset: the address of the asset to deposit
     * amount of the token to deposit
     */

    function depositCompound(address asset, uint256 amount) external {
        uint balance = IERC20(asset).balanceOf(address(this));
        require(balance >= amount, "Insuficient balance");
        IERC20(asset).safeApprove(address(compound), amount);
        compound.supply(asset, amount);
    }
    function depositCollateralCompound(address asset, uint256 amount) external {
        uint balance = IERC20(asset).balanceOf(address(this));
        require(balance >= amount, "Insuficient balance");
        // IERC20(asset).safeApprove(address(compound), amount);
        IERC20(asset).approve(address(compound), amount);
        compound.supply(asset, amount);
    }

    /**
     *@dev to withraw asset from compound
     *asset: address of the asset to withdraw
     *amount: amount to withdraw
     */
    function withdrawCompound(address asset, uint256 amount) external {
        require(
            compound.balanceOf(address(this)) <= amount,
            "insufficient balance"
        );
        compound.withdraw(asset, amount);
    }

    /**
     *@dev to borrow
     */

    function borrow(address asset, uint amount) external {
        require(
            compound.isBorrowCollateralized(address(this)),
            "insufficient collateral"
        );
        compound.withdraw(asset, amount);
    }

   function checkTotalBorrow () external view returns (uint256){
    return  compound.totalBorrow();
   }

    function myBorrowedBalance () external view returns(uint256){
        return compound.borrowBalanceOf(address(this));
    }

    function repayLoan(address asset, uint amount) external returns (bool) {
        uint repaymentAmount = compound.borrowBalanceOf(address(this));
        require(amount == repaymentAmount, 'repayment not equal owed');
        compound.supply(asset, repaymentAmount);
        return true;
    }
    function claimReward(address _claimContract, address comet) external {
        Icompound(_claimContract).claim(comet, address(this), true);
    }
    function rewardOwed(address comet, address _claimContract) external returns(RewardOwed memory reward) {
     address token =  Icompound(_claimContract).getRewardOwed(comet, address(this)).token;  
     uint owed = Icompound(_claimContract).getRewardOwed(comet, address(this)).owed;   
     reward = RewardOwed(token, owed);
    }

    function basetrackingAccrued(address account) external view returns(uint64){
        return compound.baseTrackingAccrued(account);
    }
}

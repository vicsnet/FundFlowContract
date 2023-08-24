// SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;

import './FundFlowContract.sol';
contract FFFactory {
    FundFlowContract fundFlow;
    mapping (address => address) UserAccount;
    mapping (address => bool) AccountStatus;

    function CreateAccount(address _comet) external {
        require(AccountStatus[msg.sender] = false, 'existing user');
        fundFlow = new FundFlowContract(_comet);
        UserAccount[msg.sender] = address(fundFlow);
        AccountStatus[msg.sender] = true;
    }

    function obtainUserAccount(address account) external view returns (address){
        return UserAccount[account];
    }
    function obtainAccountStatus(address account) external view returns (bool) {
        return AccountStatus[account];
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract DailyLifeContract {
    uint public balance;
    uint public maxBalance = 1000;
    uint public dailyWithdrawLimit = 200;
    
    // Event for tracking withdrawals
    event FundsWithdrawn(address indexed user, uint amount);

    mapping(address => uint) public dailyWithdrawals;

    // Function to add funds to balance
    function addFunds(uint amount) public {
        require(amount > 0, "Amount must be greater than zero.");
        assert(balance + amount <= maxBalance); // Ensure balance doesn't exceed max limit
        balance += amount;
    }

    // Function to withdraw funds with a daily limit
    function withdraw(uint amount) public {
        require(amount <= balance, "Insufficient balance.");
        require(amount + dailyWithdrawals[msg.sender] <= dailyWithdrawLimit, "Daily withdrawal limit exceeded.");
        
        if (amount % 50 != 0) {
            revert("Withdrawal amount must be a multiple of 50.");
        }

        balance -= amount;
        dailyWithdrawals[msg.sender] += amount;

        emit FundsWithdrawn(msg.sender, amount); // Emit withdrawal event
    }

    // Function to reset daily withdrawal limit whenever called
    function resetDailyLimit() public {
        dailyWithdrawals[msg.sender] = 0;
    }

    // Function to check balance status
    function checkBalance() public view returns (string memory) {
        if (balance == 0) {
            revert("Balance is empty.");
        }
        return "Balance is sufficient.";
    }
}

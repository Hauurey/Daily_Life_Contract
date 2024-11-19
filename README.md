# Solidity Token
This Solidity program implements a simple contract for managing daily withdrawals with a balance and withdrawal limits. It demonstrates basic error handling, including require, assert, and revert statements to ensure correct contract behavior and input validation. The contract also includes events for tracking withdrawals and functions for adding funds, withdrawing within limits, and resetting daily limits.

## Description
The DailyLifeContract contract is designed to handle a balance with a maximum limit, allowing users to deposit and withdraw funds within specified limits. The key features include:

  - Balance Management: Users can add funds to the contract without exceeding a maximum balance limit.
  - Daily Withdrawals: Users can withdraw funds up to a specified daily limit, with each withdrawal requiring a multiple of 50 units.
  - Withdrawal Event: Each successful withdrawal triggers an event to track the transaction.
  - Daily Limit Reset: Users can reset their daily withdrawal limit if necessary.
  
This contract showcases the use of error handling to manage deposit and withdrawal operations, ensuring safe and secure operations on the Ethereum blockchain.

## Getting Started
### Executing the Program
To run this program, you can use Remix, an online Solidity IDE. Follow these steps to get started:

1. Go to the Remix website: https://remix.ethereum.org/.
2. Create a new file by clicking on the "+" icon in the left-hand sidebar.
3. Save the file with a .sol extension (e.g., DailyLifeContract.sol).
4. Copy and paste the following code into the file:
```javascript
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
```
5. To compile the code, go to the "Solidity Compiler" tab in the left sidebar of your IDE. Make sure the compiler version is set to 0.8.28 (or another compatible version), then click the "Compile DailyLifeContract.sol" button.
6. Once compiled, deploy the contract by navigating to the "Deploy & Run Transactions" tab. Select DailyLifeContract from the dropdown menu, then click the "Deploy" button.
7. After deployment, you can interact with the contract by calling its functions:
  - Use addFunds to deposit funds into the contract.
  - Use withdraw to withdraw funds while adhering to the daily limit and withdrawal conditions.
  - Use resetDailyLimit to reset the daily withdrawal limit for the caller.
  - Use checkBalance to verify the contract's balance.

## Authors
Metacrafter Carlo Jan Harry S. Añonuevo

## License
This project is licensed under the MIT License - see the LICENSE.md file for details.

# Fungible Token Contract

This Solidity smart contract implements a basic fungible token, which means it is interchangeable and does not have a unique value.

## Description

The `TokenBasic` contract allows users to manage and transfer tokens on the Ethereum blockchain. It supports functionalities such as checking balances, transferring tokens between accounts, and approving other accounts to spend tokens on behalf of the owner.

## Contract Details

- **Name**: PichulaCoin
- **Symbol**: PCN (3 to 5 characters)
- **Decimals**: 18 (balances can be written with up to 18 decimal places)

## Core Features

- **Total Supply**: Tracks the total number of tokens available for distribution.
- **Balance Tracking**: Maps addresses to their token balances.
- **Transfer**: Allows users to transfer tokens to other addresses.
- **Approval**: Enables an address to approve another address to spend a certain amount of tokens on its behalf.
- **Allowance**: Checks the remaining tokens that a spender is allowed to spend on behalf of an owner.

## Usage

1. **Deployment**: Deploy the contract on the Ethereum network, specifying the total supply of tokens.
2. **Token Interaction**: Users can interact with the contract to check balances, transfer tokens, and approve spending.
3. **Token Transfer**: Transfer tokens between addresses using the `transfer` function.
4. **Approval Mechanism**: Approve other addresses to spend tokens on your behalf using the `approve` function.
5. **Token Spending**: Spend approved tokens using the `transferFrom` function.


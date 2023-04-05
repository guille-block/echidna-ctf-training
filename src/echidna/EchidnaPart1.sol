pragma solidity 0.8.0;

import {Token} from "../training/exercise1.sol";

contract TestExercise1 is Token {
    uint256 private constant INITIAL_SUPPLY = 10_000;
    address private echidna_caller;

    constructor() {
        echidna_caller = msg.sender;
        balances[echidna_caller] = INITIAL_SUPPLY;
    }

    /// @notice Test that user balance is never higher than its initial supply
    function echidna_test_balance() public returns (bool) {
        return balances[echidna_caller] <= INITIAL_SUPPLY;
    }
}

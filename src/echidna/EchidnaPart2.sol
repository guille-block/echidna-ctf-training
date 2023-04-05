pragma solidity 0.8.0;

import {Token} from "../training/exercise2.sol";

contract TestToken is Token {
    address echidna_caller = msg.sender;

    constructor() {
        paused();
        owner = address(0);
    }

    function echidna_no_transfer() public view returns (bool) {
        return is_paused;
    }
}

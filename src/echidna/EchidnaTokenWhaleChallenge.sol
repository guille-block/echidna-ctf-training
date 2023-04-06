pragma solidity 0.4.21;

import "../../CTF/TokenWhaleChallenge.sol";

/// @dev The issue can be found on the transferFrom function as it uses _transfer() that
/// substracts the value to the sender and not the from address.
contract EchidnaTest is TokenWhaleChallenge {
    TokenWhaleChallenge private tokenWhaleChallenge;

    function EchidnaTest() public TokenWhaleChallenge(msg.sender) {}

    function echidna_increase_balance() public view returns (bool) {
        bool state = isComplete();
        return !state;
    }
}

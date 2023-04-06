pragma solidity 0.8.0;

import "./Dex.sol";

contract Setup {
    Dex internal dex;
    SwappableToken internal token1;
    SwappableToken internal token2;

    constructor() {
        dex = new Dex();
        token1 = new SwappableToken(address(dex), "Token 1", "TKN1", 110 ether);
        token1.transfer(address(dex), 100 ether);
        token2 = new SwappableToken(address(dex), "Token 2", "TKN2", 110 ether);
        token2.transfer(address(dex), 100 ether);
        dex.setTokens(address(token1), address(token2));
        dex.renounceOwnership();
    }
}

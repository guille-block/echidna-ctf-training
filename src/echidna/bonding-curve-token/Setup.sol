pragma solidity >=0.8.0;

import "../../bonding-curve-token/LinearBondingCurveToken.sol";

/// @notice setup contract for echidna tests
contract Setup {
    LinearBondingCurveToken internal linearBondingCurveToken;

    constructor() {
        linearBondingCurveToken = new LinearBondingCurveToken("Linear Bond Curve Token", "LBCT");
    }
}

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/utils/math/Math.sol";

import "./Setup.sol";

contract EchidnaTest is Setup {
    using Math for uint256;

    event Balance(uint256 initial, uint256 finalAmount);

    event BalancePool(uint256 initial, uint256 finalAmount);

    event Tokens(uint256 initial, uint256 finalAmount);

    constructor() payable Setup() {}

    /// @dev assert on final token balance not equal to initial token balance plus the amount it MUST receive
    function testBuyHigherTokenBalance(uint256 amount) public {
        require(address(this).balance > 0);
        amount = 1 + (amount % address(this).balance);
        uint256 tokensToBuy = linearBondingCurveToken.totalSupply() +
            ((linearBondingCurveToken.totalSupply() ** 2) + amount).sqrt();
        require(tokensToBuy > 0);
        uint256 initialBalance = linearBondingCurveToken.balanceOf(address(this));
        linearBondingCurveToken.buyTokens{value: amount}(tokensToBuy);
        uint256 finalBalance = linearBondingCurveToken.balanceOf(address(this));
        emit BalancePool(address(linearBondingCurveToken).balance, 0);
        assert(initialBalance + tokensToBuy == finalBalance);
    }

    /// @dev assert on initial address balance not equal to final address balance plus the value it MUST pay
    function testBuyDecreasedAddressBalance(uint256 amount) public {
        require(address(this).balance > 0);
        amount = 1 + (amount % address(this).balance);
        uint256 tokensToBuy = linearBondingCurveToken.totalSupply() +
            ((linearBondingCurveToken.totalSupply() ** 2) + amount).sqrt();
        require(tokensToBuy > 0);
        uint256 initialBalance = address(this).balance;
        linearBondingCurveToken.buyTokens{value: amount}(tokensToBuy);
        uint256 finalBalance = address(this).balance;
        emit Balance(initialBalance + amount, finalBalance);
        emit BalancePool(address(linearBondingCurveToken).balance, 0);
        assert(initialBalance == finalBalance + amount);
    }

    /// @dev assert on initial token balance not equal to final token balance plus the amount it MUST send
    function testSellDecreasedTokenBalance(uint256 amount) public {
        require(linearBondingCurveToken.balanceOf(address(this)) > 0);
        require(amount > 0);
        amount = 1 + (amount % linearBondingCurveToken.balanceOf(address(this)));
        uint256 amountToReceive = linearBondingCurveToken.getReceivingNativeTokenAmount(amount);
        emit BalancePool(address(linearBondingCurveToken).balance, amountToReceive);
        uint256 initialBalance = linearBondingCurveToken.balanceOf(address(this));
        linearBondingCurveToken.transferAndCall(address(linearBondingCurveToken), amount);
        uint256 finalBalance = linearBondingCurveToken.balanceOf(address(this));
        emit Tokens(initialBalance, finalBalance + amount);
        assert(initialBalance == finalBalance + amount);
    }

    /// @dev assert on final address balance not equal to final initial balance plus the value it MUST receive
    function testSellIncreasedAddressBalance(uint256 amount) public {
        require(linearBondingCurveToken.balanceOf(address(this)) > 0);
        require(amount > 0);
        amount = 1 + (amount % linearBondingCurveToken.balanceOf(address(this)));
        uint256 amountToReceive = linearBondingCurveToken.getReceivingNativeTokenAmount(amount);
        emit BalancePool(address(linearBondingCurveToken).balance, amountToReceive);
        uint256 initialBalance = address(this).balance;
        linearBondingCurveToken.transferAndCall(address(linearBondingCurveToken), amount);
        uint256 finalBalance = address(this).balance;
        emit Balance(initialBalance + amountToReceive, finalBalance);
        assert(initialBalance + amountToReceive == finalBalance);
    }
}

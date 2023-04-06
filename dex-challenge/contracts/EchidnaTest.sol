pragma solidity 0.8.0;

import "./Setup.sol";

contract EchidnaTest is Setup {
    event FailSwap(uint256 prevBalance1, uint256 afterBalance1, uint256 prevBalance2, uint256 afterBalance2);
    event SwapAmount(uint256 receiveAmount);

    function swap1(uint256 amount) public {
        require(token2.balanceOf(address(this)) > 0 && token1.balanceOf(address(this)) > 0);
        uint256 preThisBalanceToken1 = token1.balanceOf(address(this));
        uint256 preThisBalanceToken2 = token2.balanceOf(address(this));
        amount =
            1 +
            (amount % (preThisBalanceToken1 < preThisBalanceToken2 ? preThisBalanceToken1 : preThisBalanceToken2));
        token1.approve(address(dex), amount);
        uint256 swapPriceFirst = dex.getSwapPrice(address(token1), address(token2), amount);
        emit SwapAmount(swapPriceFirst);
        dex.swap(address(token1), address(token2), amount);
        uint256 swapThisBalanceToken2 = token2.balanceOf(address(this)) - preThisBalanceToken2;
        token2.approve(address(dex), swapThisBalanceToken2);
        uint256 swapPriceSecond = dex.getSwapPrice(address(token2), address(token1), swapThisBalanceToken2);
        emit SwapAmount(swapPriceSecond);
        dex.swap(address(token2), address(token1), swapThisBalanceToken2);
    }

    function testSwap(uint256 amount) public {
        require(token2.balanceOf(address(this)) > 0 && token1.balanceOf(address(this)) > 0);
        uint256 preThisBalanceToken1 = token1.balanceOf(address(this));
        uint256 preThisBalanceToken2 = token2.balanceOf(address(this));
        amount =
            1 +
            (amount % (preThisBalanceToken1 < preThisBalanceToken2 ? preThisBalanceToken1 : preThisBalanceToken2));
        token1.approve(address(dex), amount);
        uint256 swapPriceFirst = dex.getSwapPrice(address(token1), address(token2), amount);
        emit SwapAmount(swapPriceFirst);
        dex.swap(address(token1), address(token2), amount);
        uint256 swapThisBalanceToken2 = token2.balanceOf(address(this)) - preThisBalanceToken2;
        token2.approve(address(dex), swapThisBalanceToken2);
        uint256 swapPriceSecond = dex.getSwapPrice(address(token2), address(token1), swapThisBalanceToken2);
        emit SwapAmount(swapPriceSecond);
        dex.swap(address(token2), address(token1), swapThisBalanceToken2);
        uint256 afterThisBalanceToken1 = token1.balanceOf(address(this));
        uint256 afterThisBalanceToken2 = token2.balanceOf(address(this));
        emit FailSwap(preThisBalanceToken1, afterThisBalanceToken1, preThisBalanceToken2, afterThisBalanceToken2);
        assert(afterThisBalanceToken1 != 110 ether);
    }
}

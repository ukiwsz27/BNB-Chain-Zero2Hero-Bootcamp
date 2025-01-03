// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BadLotteryGame {
    uint256 public prizeAmount; // payout amount
    address payable[] public players;
    uint256 public num_players;
    address payable[] public prize_winners;
    event winnersPaid(uint256);

    constructor() {}

    function addNewPlayer(address payable _playerAddress) public payable {
        /// this IF block check wheter the sender sent 500000 wei
        if (msg.value == 500000) {
            players.push(_playerAddress);
        }
        /// but num_players still increment even though the previous IF is not executed, inflating the players
        num_players++;
        if (num_players > 50) {
            emit winnersPaid(prizeAmount);
        }
    }

    function pickWinner(address payable _winner) public {
        /// a bad practice is using block.timestamp for random number because it can be predicted.
        /// pickWinner also have a variable address that is not checked with players array in the first function.
        /// worse, the function is public: everyone can submit their address without paying with this function.
        /// and given the correct timestamp, it will be added to the prize_winners array.
        if (block.timestamp % 15 == 0) {
            // use timestamp for random number
            prize_winners.push(_winner);
        }
    }

    function payout() public {
        /// this function can potentially making this contract hold stuck balance because the strict requirement of having
        /// exactly 500000 * 100 wei to execute.
        if (address(this).balance == 500000 * 100) {
            /// this function making the amountToPay so low? why?
            uint256 amountToPay = prize_winners.length / 100;
            distributePrize(amountToPay);
        }
    }

    function distributePrize(uint256 _amount) public {
        /// this function is public, so the distributePrize can be called event though the payout function
        /// that require address(this).balance == 500000 * 100
        /// basically attacker just need to execute pickWinner and distributePrize for them to drain this address balance
        for (uint256 i = 0; i <= prize_winners.length; i++) {
            prize_winners[i].transfer(_amount);
        }
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Shuffle {
    struct Card {
        uint8 suit; // 1-4
        uint8 rank; // 1-13
    }

    Card[] public deck;

    constructor() {
        // Create a deck of cards
        for (uint8 suit = 1; suit <= 4; suit++) {
            for (uint8 rank = 1; rank <= 13; rank++) {
                deck.push(Card(suit, rank));
            }
        }
    }

    function shuffle() public {
        uint256 deckSize = deck.length;
        for (uint256 i = 0; i < deckSize; i++) {
            uint256 j = uint256(keccak256(abi.encode(block.prevrandao, i))) % deckSize;
            Card memory tmpCard = deck[i];
            deck[i] = deck[j];
            deck[j] = tmpCard;
        }
    }
}
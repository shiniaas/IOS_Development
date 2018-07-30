//
//  Concentration.swift
//  Concentration
//
//  Created by lifan on 2018/7/25.
//  Copyright © 2018 lifan. All rights reserved.
//

import Foundation
import GameplayKit

class Concentration
{
    var cards =  [Card]()
    var indexOfOneAndOnluFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let upIndex = indexOfOneAndOnluFaceUpCard {
                if upIndex != index {
                    //matched?
                    if cards[upIndex].identifier == cards[index].identifier {
                        cards[upIndex].isMatched = true
                        cards[index].isMatched = true
                    }
                    cards[index].isFaceUp = true
                } else {
                    cards[index].isFaceUp = false
                }
                indexOfOneAndOnluFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = cards[flipDownIndex].isMatched ? true :false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnluFaceUpCard = index
            }
        }
    }
    
    func restart() {
        cards = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cards) as! [Card]
        indexOfOneAndOnluFaceUpCard = nil
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //TODO: Shuffle the cards
        cards = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cards) as! [Card]
    }
    
}

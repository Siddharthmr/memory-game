//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Siddharth M on 1/4/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for index in 0..<max(2, numPairs) {
            let content = cardContentFactory(index)
            cards.append(Card(id: "\(index + 1)a", content: content))
            cards.append(Card(id: "\(index + 1)b" , content: content))
        }
    }
    
    var indexOfFaceUp: Int? {
        get {
            cards.indices.filter {
                index in cards[index].isFaceUp
            }.only
        }
        set {
            cards.indices.forEach {
                cards[$0].isFaceUp = newValue == $0
            }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let matchIndex = indexOfFaceUp {
                    if cards[chosenIndex].content == cards[matchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[matchIndex].isMatched = true
                    }
                } else {
                    indexOfFaceUp = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true;
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        var id: String
        
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}

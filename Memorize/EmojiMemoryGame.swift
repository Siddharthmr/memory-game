//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Siddharth M on 1/4/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🐒", "🦊", "🐶", "🦁", "🐶"]

    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numPairs: 4) { index in
            if emojis.indices.contains(index) {
                return emojis[index]
            } else {
                return ""
            }
        }
    }
        
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}

//
//  ContentView.swift
//  Memorize
//
//  Created by Siddharth M on 12/31/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    let emojis = ["🐒", "🦊", "🐶", "🦁", "🐶"]
    var body: some View {
        Group {
            cards
                .animation(.default, value: viewModel.cards)
            Button("shuffle") {
                viewModel.shuffle()
            }
        }
        .padding(15)
        .font(.largeTitle)
    }
    var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
    
    
}

struct CardView : View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let rect = RoundedRectangle(cornerRadius: 12.0)
            rect.fill(.white).opacity(0.2)
            rect.strokeBorder(lineWidth: 2)
            Text(card.content)
                .font(.system(size: 200))
                .minimumScaleFactor(0.01)
                .aspectRatio(1, contentMode: .fit)
            rect.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}
#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
    

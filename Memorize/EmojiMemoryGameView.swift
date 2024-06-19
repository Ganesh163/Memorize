//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by sgv on 01/12/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 3/4
    
    var body: some View {
        VStack{
            HStack{
                Text(viewModel.selectedTheme.name)
                Spacer()
                Text("Score : \(viewModel.score)")
            }
            .font(.title)
            cards
                .animation(.default, value: viewModel.cards)
            buttons
        }
        .padding(.horizontal)
    }
    
    private var cards: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize),spacing: 0)],spacing: 0){
                ForEach(viewModel.cards){ card in
                    CardView(card)
                        .aspectRatio(aspectRatio ,contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(Color.fromString(viewModel.selectedTheme.colour))
    }
    
    private func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat 
    {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
    
    private var buttons: some View {
        HStack{
            Button(action: {
                viewModel.shuffle()
            }, label: {
                Image(systemName:"shuffle")
                    .font(.title3) // Custom font size
                    .foregroundColor(.white) // Text color
                    .padding() // Inner padding
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(15) // Rounded corners
                    .shadow(color: .gray, radius: 5, x: 0, y: 5) // Shadow
            })
            Button(action: {
                viewModel.createGame()
            }, label: {
                Image(systemName:"plus")
                    .font(.title2) // Custom font size
                    .foregroundColor(.white) // Text color
                    .padding() // Inner padding
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(15) // Rounded corners
                    .shadow(color: .gray, radius: 5, x: 0, y: 5) // Shadow
            })
        }
    }
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 10)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {  
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}


extension Color {
    static func fromString(_ colorString: String) -> Color {
        switch colorString.lowercased() {
        case "red":
            return .red
        case "green":
            return .green
        case "blue":
            return .blue
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        case "purple":
            return .purple
        case "pink":
            return .pink
        case "gray":
            return .gray
        case "black":
            return .black
        case "white":
            return .white
        default:
            return .clear // Default color if no match is found
        }
    }
}

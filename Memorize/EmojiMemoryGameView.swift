//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by sgv on 01/12/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame

    @State var emojis : [String] = []
    
    var body: some View {
        VStack{
            HStack{
                Text(viewModel.selectedTheme.name)
                Spacer()
                Text("Score : \(viewModel.score)")
            }
            .font(.title)
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            buttons
        }
        .padding(.horizontal)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85),spacing: 0)],spacing: 0){
            ForEach(viewModel.cards){ card in
                CardView(card)
                    .aspectRatio( 2/3,contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(Color.fromString(viewModel.selectedTheme.colour))
    }
    
    var buttons: some View {
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

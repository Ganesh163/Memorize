//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by sgv on 01/12/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    let vehicleEmoji = ["🛵","🛺","✈️","🚆","🛳️","🚁","🚎","🚲"]
    let animalEmoji = ["🐯","🐭","🐶","🐵","🐤","🦄","🐍","🦉"]
    let haloweenEmoji = ["🕷️","😈","👻","🌙","🍴","👹","☠️","🦂"]
    
    @ObservedObject var viewModel: EmojiMemoryGame

    @State var emojis : [String] = []
    
    var body: some View {
        VStack{
            Text("Memorize!").font(.largeTitle)
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards  )
            }
            Button("Shuffle"){
                viewModel.shuffle()
            }
            Spacer()
            cardThemeAdjusters
        }
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
        .padding()
        .foregroundColor(.orange)
    }
    
    var cardThemeAdjusters : some View {
        HStack{
            cardThemeAdjuster(themeName:"Vehicles", symbol: "car.circle")
            cardThemeAdjuster(themeName:"Animals", symbol: "fish.circle")
            cardThemeAdjuster(themeName:"Haloween", symbol: "theatermasks.circle")
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardThemeAdjuster(themeName: String, symbol: String) -> some View {
        VStack{
            Button(action: {
                if themeName == "Vehicles" {
                    emojis = (vehicleEmoji + vehicleEmoji).shuffled()
                }else if themeName == "Animals" {
                    emojis = (animalEmoji + animalEmoji).shuffled()
                }else{
                    emojis = (haloweenEmoji + haloweenEmoji).shuffled()
                }
            }, label: {
                Image(systemName: symbol)
            })
            Text(themeName).font(.title3)
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        .padding()
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

//
//  ContentView.swift
//  Memorize
//
//  Created by sgv on 01/12/23.
//

import SwiftUI

struct ContentView: View {
    
    let vehicleEmoji = ["🛵","🛺","✈️","🚆","🛳️","🚁","🚎","🚲"]
    let animalEmoji = ["🐯","🐭","🐶","🐵","🐤","🦄","🐍","🦉"]
    let haloweenEmoji = ["🕷️","😈","👻","🌙","🍴","👹","☠️","🦂"]

    @State var emojis : [String] = []
    
    var body: some View {
        VStack{
            Text("Memorize!").font(.largeTitle)
            ScrollView{
                cards
            }
            Spacer()
            cardThemeAdjusters
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]){
            ForEach(0..<emojis.count, id: \.self){ index in
                CardView(context: emojis[index])
                    .aspectRatio(2/3,contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
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
    let context: String
    @State var isFaceUp = false
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 10)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(context).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}

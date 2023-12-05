//
//  ContentView.swift
//  Memorize
//
//  Created by sgv on 01/12/23.
//

import SwiftUI

struct ContentView: View {
    let emoji = ["🕷️","😈","👻","🌙"]
    var body: some View {
        VStack {
            ForEach(emoji.indices, id: \.self){ index in
                CardView(context: emoji[index])
            }
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    let context: String
    @State var isFaceUp = false
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 10)
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(context).font(.largeTitle)
            }else{
                base
            }
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}

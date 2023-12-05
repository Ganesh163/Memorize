//
//  ContentView.swift
//  Memorize
//
//  Created by sgv on 01/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CardView(isFaceUp: true)
            CardView()
            CardView(isFaceUp: true)
            CardView()
        }
        .padding()
        .foregroundColor(.blue)
    }
}

struct CardView: View {
    var isFaceUp: Bool = false
    var body: some View {
        if isFaceUp {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(lineWidth: 2)
                Text("🤑").font(.largeTitle)
            }
        }else{
            RoundedRectangle(cornerRadius: 10)
        }
    }
}

#Preview {
    ContentView()
}

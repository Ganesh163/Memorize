import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🕷️","😈","👻","🌙","🍴","👹","☠️","🦂"]
    
    @Published private var model = MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
        if emojis.indices.contains(pairIndex){
            return emojis[pairIndex]
        }else{
            return "⁉️"
        }
    }
    
    var cards : Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card : MemoryGame<String>.Card){
        model.choose(card)
    }
}

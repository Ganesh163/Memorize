import SwiftUI

struct MemoryGame<CardContent> {
    private(set) var cards : Array<Card>
    
    init(numberOfPairsOfCards: Int){
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for _ in 0..<numberOfPairsOfCards{
            cards.append(Card(isFaceUp: false, isMatched: false, content: <#T##CardContent#>))
            cards.append(Card(isFaceUp: false, isMatched: false, content: <#T##CardContent#>))
        }
    }
    
    func choose (card: Card){
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content : CardContent
    }
}

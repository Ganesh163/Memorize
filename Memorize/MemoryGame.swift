import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards : Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    var indexOfTheOnlyFaceUpCard : Int? {
        get { cards.indices.filter {index in cards[index].isFaceUp}.only }
        set { cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0)} }
    }
    
    mutating func choose (_ card: Card){
        if let chosenIndex = index(of: card) {
            if (!cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched) {
                if let potentialMatchIndex = indexOfTheOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id{
                return index
            }
        }
        return nil
    }
    
    struct Card : Equatable, Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content : CardContent
        
        var id: String
    }
}

extension Array {
    var only : Element? {
        count == 1 ? first : nil
    }
}

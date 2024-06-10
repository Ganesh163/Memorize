import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards : Array<Card>
    private(set) var score : Int = 0
    
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
                        score(card: cards[chosenIndex], matchWith: cards[potentialMatchIndex])
                    } else {
                        score(card: cards[chosenIndex], matchWith: cards[potentialMatchIndex])
                        cards[chosenIndex].hasBeenSeen = true
                        cards[potentialMatchIndex].hasBeenSeen = true
                    }
                    cards[chosenIndex].isFaceUp = true
                } else {
                    indexOfTheOnlyFaceUpCard = chosenIndex
                }
            }
        }
    }
    
    mutating func score(card: Card, matchWith potentialMatch: Card) {
        if card.content == potentialMatch.content {
            score += 4 // Award 4 points for a match
        } else {
            if card.hasBeenSeen {
                score -= 1 // Penalize for previously seen card
            }
            if potentialMatch.hasBeenSeen {
                score -= 1 // Penalize for previously seen card
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
        var hasBeenSeen = false
        let content : CardContent
        
        var id: String
    }
}

extension Array {
    var only : Element? {
        count == 1 ? first : nil
    }
}

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    init(){
        self.selectedTheme = EmojiMemoryGame.themes.randomElement() ?? EmojiMemoryGame.themes[0]
        self.model = EmojiMemoryGame.createMemoryGame(theme: self.selectedTheme)
        self.model.shuffle()
    }
    
    struct Theme{
        var name: String
        var emojis: [String]
        var colour: String
    }
    
    static let themes = [
        Theme(name: "Haloween", emojis: ["🕷️","😈","👻","🌑","🔪","👹","☠️","🎃","👽","👺"], colour: "black"),
        Theme(name: "Party", emojis: ["💃🏻","🍷","🍽️","🎼","🥁","🎸","🎹","🎤","🎧","🎮"], colour: "green"),
        Theme(name: "Smily", emojis: ["😍","😇","🤩","🥶","😱","🤧","😴","🤭","😡","😉"], colour: "yellow"),
        Theme(name: "Vehicle", emojis: ["🚗","🚑","🚚","🚘","🚲","✈️","🛥️","🚉","🚀","🚁"], colour: "blue"),
        Theme(name: "Flags", emojis: ["🇦🇷","🇦🇺","🇮🇳","🇬🇷","🇳🇿","🇨🇿","🇱🇷","🇯🇵","🇫🇲","🇳🇦"], colour: "purple"),
        Theme(name: "Hearts", emojis: ["❣️","❤️","🧡","💞","💚","💝","💙","💜","❤️‍🩹","🤎"], colour: "red"),
        Theme(name: "Food", emojis: ["🍗","🥪","🍙","🥮","🍭","🍰","🧁","🍿","🍩","🍻"], colour: "pink")
    ]
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            if theme.emojis.indices.contains(pairIndex){
                return theme.emojis[pairIndex]
            }else{
                return "⁉️"
            }
        }
    }
    
    @Published private var model: MemoryGame<String>
    
    var cards : Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score : Int {
        return model.score
    }
    
    var selectedTheme : Theme
    
    //INTENTS
    
    func createGame(){
        selectedTheme = EmojiMemoryGame.themes.randomElement() ?? EmojiMemoryGame.themes[0]
        model = EmojiMemoryGame.createMemoryGame(theme: selectedTheme)
        model.shuffle()
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card : MemoryGame<String>.Card){
        model.choose(card)
    }
}

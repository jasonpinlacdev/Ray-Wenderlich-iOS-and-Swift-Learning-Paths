
import Foundation

class Emoji {
    enum Category: String, CaseIterable {
        case smileysAndPeople = "Smileys & People"
        case animalsAndNature = "Animals & Nature"
        case foodAndDrink = "Food & Drink"
        case activity = "Activity"
        case travelAndPlaces = "Travel & Places"
        case objects = "Objects"
        case symbols = "Symbols"
        case flags = "Flags"
    }
    
    // singleton
    static let shared = Emoji()
    
    // uses an enum that adopts protocol CaseIterable
    let sections = Category.allCases
    
    // dictionary that represents enum catgeory to an array of string emojis
    var data: [Category: [String]] = [
        .smileysAndPeople: ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😊", "😊", "😇", "🙂", "😎", "🤩", "😴", "😬", "🥵"],
        .animalsAndNature: ["🐶", "🐱", "🦊", "🐻", "🦁", "🐮", "🐸", "🐵", "🐔", "🐧", "🦉", "🐴", "🦋", "🐙", "🐬", "🐈", "🌲", "🌍"],
        .foodAndDrink:     ["🍏", "🍇", "🍓", "🥝", "🍅", "🌽", "🥕", "🥨", "🧀", "🍖", "🦴", "🌮", "🍣", "🥤", "🥃", "🥟", "🍺", "🍪"],
        .activity:         ["⚽️", "🏉", "🥏", "🏏", "🥅", "🛹", "🛷", "🏋️‍♂️", "🏅", "🎪", "🎬", "🎼", "🎲", "🎳", "🎮", "🎸", "🧩", "🏆"],
        .travelAndPlaces:  ["🚗", "🚑", "🚨", "🚠", "🚟", "🚄", "✈️", "🚤", "🚧", "🏠", "⛱", "🌋", "⛩", "🕋", "⛪️", "🌠", "🌇", "🗽"],
        .objects:          ["⌚️", "🖱", "🖲", "💾", "☎️", "📺", "💴", "🔨", "🧰", "🧲", "🎁", "🎊", "✉️", "🗳", "📌", "🔍", "🔐", "💰"],
        .symbols:          ["❤️", "💔", "☮️", "☯️", "☢️", "🆚", "🉐", "🆘", "❌", "💯", "‼️", "🚸", "⚜️", "♿️", "🔈", "🔔", "♣️", "🚸"],
        .flags:            ["🏳️", "🇺🇸", "🇯🇵", "🇩🇪", "🇨🇦", "🇲🇽", "🇧🇷", "🇰🇪", "🇳🇬", "🇮🇳", "🇷🇺", "🇦🇺", "🇫🇷", "🇵🇱", "🇻🇳", "🇱🇹", "🇱🇰", "🇪🇪"]
    ]
    
    private init() {}
    
    func getEmoji(at indexPath: IndexPath) -> String? {
        let categoryKey = sections[indexPath.section]
        return data[categoryKey]?[indexPath.row]
    }
    
    static func randomEmoji() -> (Category, String) {
        let extraEmoji = ["💀", "🤖", "👍", "🤘🏾", "🖐🏼", "👇🏽", "🙏🏾", "👀", "👩🏽‍🦱", "👩🏿", "🧕🏽", "🕵🏻‍♂️", "👨🏼‍💻", "👭", "🧚🏾‍♂️", "💍"]
        let randomIndex = Int.random(in: 0..<extraEmoji.count)
        return (.smileysAndPeople, extraEmoji[randomIndex])
    }
    
}

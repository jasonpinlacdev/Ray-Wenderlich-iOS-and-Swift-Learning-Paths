
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
    
    func addEmoji(_ emoji: String, to category: Emoji.Category) {
        guard var emojiCategoryData = data[category] else { return }
        emojiCategoryData.append(emoji)
        Emoji.shared.data.updateValue(emojiCategoryData, forKey: category)
    }
    
    func deleteEmojis(at indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            let category = Emoji.shared.sections[indexPath.section]
            guard var emojiCategoryData = Emoji.shared.data[category] else { return }
            emojiCategoryData.remove(at: indexPath.row)
            Emoji.shared.data.updateValue(emojiCategoryData, forKey: category)
        }
    }
    
}

//
//  DataRepository.swift
//  EmojiLibrary
//
//  Created by Jason Pinlac on 9/28/21.
//

import Foundation



class DataRepository {
  
  enum EmojiSectionCategory: String, CaseIterable {
    case smileysAndPeople = "Smileys & People"
    case animalsAndNature = "Animals & Nature"
    case foodAndDrink = "Food & Drink"
    case activity = "Activity"
    case travelAndPlaces = "Travel & Places"
    case objects = "Objects"
    case symbols = "Symbols"
    case flags = "Flags"
  }
  
  static let shared = DataRepository()
  
  private init() { }

  let emojiSections: [EmojiSectionCategory] = EmojiSectionCategory.allCases
  var emojiData: [EmojiSectionCategory: [String]] = [
    .smileysAndPeople: ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😊", "🤯", "😇", "🙂", "😎", "🤩", "😴", "😬", "🥵"],
    .animalsAndNature: ["🐶", "🐱", "🦊", "🐻", "🦁", "🐮", "🐸", "🐵", "🐔", "🐧", "🦉", "🐴", "🦋", "🐙", "🐬", "🐈", "🌲", "🌍"],
    .foodAndDrink:     ["🍏", "🍇", "🍓", "🥝", "🍅", "🌽", "🥕", "🥨", "🧀", "🍖", "🦴", "🌮", "🍣", "🥤", "🥃", "🥟", "🍺", "🍪"],
    .activity:         ["⚽️", "🏉", "🥏", "🏏", "🥅", "🛹", "🛷", "🏋️‍♂️", "🏅", "🎪", "🎬", "🎼", "🎲", "🎳", "🎮", "🎸", "🧩", "🏆"],
    .travelAndPlaces:  ["🚗", "🚑", "🚨", "🚠", "🚟", "🚄", "✈️", "🚤", "🚧", "🏠", "⛱", "🌋", "⛩", "🕋", "⛪️", "🌠", "🌇", "🗽"],
    .objects:          ["⌚️", "🖱", "🖲", "💾", "☎️", "📺", "💴", "🔨", "🧰", "🧲", "🎁", "🎊", "✉️", "🗳", "📌", "🔍", "🔐", "💰"],
    .symbols:          ["❤️", "💔", "☮️", "☯️", "☢️", "🆚", "🉐", "🆘", "❌", "💯", "‼️", "🚸", "⚜️", "♿️", "🔈", "🔔", "♣️", "🚸"],
    .flags:            ["🏳️", "🇺🇸", "🇯🇵", "🇩🇪", "🇨🇦", "🇲🇽", "🇧🇷", "🇰🇪", "🇳🇬", "🇮🇳", "🇷🇺", "🇦🇺", "🇫🇷", "🇵🇱", "🇻🇳", "🇱🇹", "🇱🇰", "🇪🇪"]
  ]
  
  var randomSectionAndEmoji: (section: EmojiSectionCategory, emoji: String) {
    let randomSectionIndex = Int.random(in: 0..<EmojiSectionCategory.allCases.count)
    let randomSection = EmojiSectionCategory.allCases[randomSectionIndex]
    let randomEmojiInSectionIndex = Int.random(in: 0..<emojiData[randomSection]!.count)
    let randomEmoji = emojiData[randomSection]![randomEmojiInSectionIndex]
    return (randomSection, randomEmoji)
  }
  
//  static func randomEmoji() -> (Category, String) {
//    let extraEmoji = ["💀", "🤖", "👍", "🤘🏾", "🖐🏼", "👇🏽", "🙏🏾", "👀", "👩🏽‍🦱", "👩🏿", "🧕🏽", "🕵🏻‍♂️", "👨🏼‍💻", "👭", "🧚🏾‍♂️", "💍"]
//    let randomIndex = Int.random(in: 0..<extraEmoji.count)
//    return (.smileysAndPeople, extraEmoji[randomIndex])
//  }
}

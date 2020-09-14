import Foundation

// MARK: - FILE MANAGAER CLASS AND THE DOCUMENT DIRECTORY AND ITS URL

// The FileManager class is used to return URLS of an app's directories. Here is a useful extension to quickly referencing the user's app document directory

extension FileManager {
    static var documentDirectoryURL: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

FileManager.documentDirectoryURL

// MARK: - 2 WAYS OF CREATING A FILE/COMPONENT RELATIVE TO A PATH WITH EXTENSION

//var DnDDataURL: URL = URL(fileURLWithPath: "DnD.txt", relativeTo: FileManager.documentDirectoryURL)

var DnDStringURL: URL = FileManager.documentDirectoryURL.appendingPathComponent("DnD").appendingPathExtension("txt")

DnDStringURL.path
DnDStringURL.lastPathComponent

// MARK: - SWIFT FOUNDATION DATA TYPES (structs) and DATA (bytes)

// Swift's Foundation type Data is a struct. But also when we say data we mean bytes of data that can be represented by Swift's built-in data types.

// Int - there are variations of 8, 16, 32, 64 byte sized Ints. There is also unsigned versions for each.
var int8: Int8
var int16: Int16
var int32: Int32
var int64: Int64
var uInt64: UInt64

var smallestSignedInt: Int8 = Int8.min
var largestSignedInt: Int8 = Int8.max

// Float - 32 bits
Float.leastNormalMagnitude
Float.greatestFiniteMagnitude

// Double - 64 bits
// String
// Boolean

// the enum MemoryLayout can be used to find the min/max and size of data types in bytes.
let number: UInt64 = 255
MemoryLayout.size(ofValue: number) // size of a value
MemoryLayout<UInt64>.size // size of a data type

// MARK: - SAVING DATA
// serialize - Data()
// create url
// write - data.write(to: url)

let favoriteBytes: [UInt8] = [
    240,          159,          152,          184,
    240,          159,          152,          185,
    0b1111_0000,  0b1001_1111,  0b1001_1000,  186,
    0xF0,         0x9F,         0x98,         187
]

let favoritesBytesData = Data(favoriteBytes)
let favoritesBytesURL = URL(fileURLWithPath: "Favorite Bytes", relativeTo: FileManager.documentDirectoryURL)
do {
    try favoritesBytesData.write(to: favoritesBytesURL)
} catch {
    print(error)
}

// MARK: - LOADING DATA
// get data at url - Data(contentsOf: url)
// deserialize - Array(data)

do {
    let savedFavoriteBytesData = try Data(contentsOf: favoritesBytesURL)
    let savedFavoriteBytes = Array(savedFavoriteBytesData)
    savedFavoriteBytes == favoriteBytes
    savedFavoriteBytesData == favoritesBytesData
} catch {
    print(error)
}

// MARK: - SAVING DATA TO A TXT FILE AND LOADING IT AS A STRING

// Now lets save favorites bytes into a .txt file extension to see what the data looks like is represented as a string. txt file makes it legible.
let favoritesBytesTxtURL = FileManager.documentDirectoryURL.appendingPathComponent("Favorite Bytes").appendingPathExtension("txt")

try favoritesBytesData.write(to: favoritesBytesTxtURL)


// now convert that txt data to a swift string
let favoriteBytesString = String(data: try Data(contentsOf: favoritesBytesTxtURL), encoding: .utf8)!

// MARK: - SAVING A STRING TO A FILE AND LOADING IT AS A STRING

// saving a string to url
let catsURL = URL(fileURLWithPath: "Cats", relativeTo: FileManager.documentDirectoryURL)

try favoriteBytesString.write(to: catsURL, atomically: true, encoding: .utf8)

let catsString = try String(contentsOf: catsURL)

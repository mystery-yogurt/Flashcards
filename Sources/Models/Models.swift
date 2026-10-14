import Foundation

struct WordDictionary: Identifiable {
    let id = UUID()
    let name: String
    let wordsCount: Int
    let colorHex: String
}

struct StudyStatistic: Identifiable {
    let id = UUID()
    let day: String
    let learnedWords: Int
}

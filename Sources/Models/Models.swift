import Foundation

struct WordDictionary: Identifiable, Hashable {
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

struct Flashcard: Identifiable {
    let id = UUID()
    var word: String
    var transcription: String
    var translation: String
    var example: String
    var memoryLevel: Double
}

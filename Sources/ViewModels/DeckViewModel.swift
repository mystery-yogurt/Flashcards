import Foundation
import Combine

class DeckViewModel: ObservableObject {
    @Published var dictionary: WordDictionary
    @Published var cards: [Flashcard] = []

    @Published var scannedWord: String = "" {
        didSet {
            if !scannedWord.isEmpty {
                processScannedWord(scannedWord)
            }
        }
    }
    
    init(dictionary: WordDictionary) {
        self.dictionary = dictionary
        loadMockCards()
    }
    
    private func loadMockCards() {
        cards = [
            Flashcard(word: "Developer", transcription: "[dɪˈveləpə]", translation: "Разработчик", example: "He is a software developer.", memoryLevel: 0.8),
            Flashcard(word: "Variable", transcription: "[ˈveərɪəbl]", translation: "Переменная", example: "Assign a value to the variable.", memoryLevel: 0.4),
            Flashcard(word: "Framework", transcription: "[ˈfreɪmwɜːk]", translation: "Фреймворк / Каркас", example: "SwiftUI is a declarative framework.", memoryLevel: 0.1)
        ]
    }
    
    private func processScannedWord(_ text: String) {
        let newCard = Flashcard(
            word: text.capitalized,
            transcription: "[...]",
            translation: "Перевод (ожидает загрузки)",
            example: "Пример использования...",
            memoryLevel: 0.0
        )
        cards.append(newCard)
    }
}

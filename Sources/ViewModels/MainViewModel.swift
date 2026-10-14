import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var dictionaries: [WordDictionary] = []
    @Published var weeklyStats: [StudyStatistic] = []
    
    init() {
        loadMockData()
    }

    private func loadMockData() {
        dictionaries = [
            WordDictionary(name: "Английский (Базовый)", wordsCount: 500, colorHex: "3498db"),
            WordDictionary(name: "IT Термины", wordsCount: 150, colorHex: "9b59b6"),
            WordDictionary(name: "Немецкий (A1)", wordsCount: 300, colorHex: "e74c3c")
        ]
        
        weeklyStats = [
            StudyStatistic(day: "Пн", learnedWords: 15),
            StudyStatistic(day: "Вт", learnedWords: 22),
            StudyStatistic(day: "Ср", learnedWords: 8),
            StudyStatistic(day: "Чт", learnedWords: 35),
            StudyStatistic(day: "Пт", learnedWords: 12),
            StudyStatistic(day: "Сб", learnedWords: 45),
            StudyStatistic(day: "Вс", learnedWords: 20)
        ]
    }
    
    func startSession() {
        print("Запуск сессии интервальных повторений...")
    }
}

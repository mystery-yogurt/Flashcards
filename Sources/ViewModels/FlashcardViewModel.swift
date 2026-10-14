import Foundation
import Combine

class FlashcardViewModel: ObservableObject {
    @Published var card: Flashcard
    @Published var isFlipped: Bool = false
    
    init(card: Flashcard) {
        self.card = card
    }
    
    func flipCard() {
        isFlipped.toggle()
    }
}

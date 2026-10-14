import SwiftUI
import VisionKit

struct DeckView: View {
    @StateObject var viewModel: DeckViewModel
    @State private var isShowingScanner = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(viewModel.cards) { card in
                    FlashcardView(viewModel: FlashcardViewModel(card: card))
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle(viewModel.dictionary.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                        isShowingScanner = true
                    } else {
                        print("Сканирование не поддерживается на данном устройстве/симуляторе")
                    }
                }) {
                    Image(systemName: "camera.viewfinder")
                }
            }
        }
        .sheet(isPresented: $isShowingScanner) {
            TextScannerView(recognizedText: $viewModel.scannedWord)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

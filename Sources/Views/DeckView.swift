import SwiftUI
#if !targetEnvironment(simulator)
import VisionKit
#endif

struct DeckView: View {
    @StateObject var viewModel: DeckViewModel
    @State private var isShowingScanner = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                if viewModel.cards.isEmpty {
                    Text("Словарь пуст. Отсканируйте новые слова.")
                        .foregroundColor(.gray)
                        .padding(.top, 50)
                } else {
                    ForEach(viewModel.cards) { card in
                        FlashcardView(viewModel: FlashcardViewModel(card: card))
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle(viewModel.dictionary.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isShowingScanner = true
                }) {
                    Image(systemName: "camera.viewfinder")
                }
            }
        }
        .sheet(isPresented: $isShowingScanner) {
            #if targetEnvironment(simulator)
                SimulatedScannerView(recognizedText: $viewModel.scannedWord)
            #else
                if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                    TextScannerView(recognizedText: $viewModel.scannedWord)
                        .edgesIgnoringSafeArea(.all)
                } else {
                    SimulatedScannerView(recognizedText: $viewModel.scannedWord)
                }
            #endif
        }
    }
}

import SwiftUI

struct FlashcardView: View {
    @StateObject var viewModel: FlashcardViewModel
    
    var body: some View {
        ZStack {
            cardBack
                .opacity(viewModel.isFlipped ? 1.0 : 0.0)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))

            cardFront
                .opacity(viewModel.isFlipped ? 0.0 : 1.0)
        }
        .rotation3DEffect(
            .degrees(viewModel.isFlipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0), value: viewModel.isFlipped)
        .onTapGesture {
            viewModel.flipCard()
        }
    }
    
    private var cardFront: some View {
        VStack(spacing: 16) {
            Text(viewModel.card.word)
                .font(.system(size: 36, weight: .bold))
            
            Text(viewModel.card.transcription)
                .font(.title2)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, minHeight: 300)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    private var cardBack: some View {
        VStack(spacing: 20) {
            Text(viewModel.card.translation)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.blue)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Пример использования:")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(viewModel.card.example)
                    .font(.body)
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Spacer()
            
            VStack(spacing: 8) {
                Text("Уровень запоминания")
                    .font(.caption)
                    .foregroundColor(.gray)
                ProgressView(value: viewModel.card.memoryLevel)
                    .progressViewStyle(.linear)
                    .tint(viewModel.card.memoryLevel > 0.7 ? .green : .orange)
                    .padding(.horizontal)
            }
        }
        .padding(.vertical, 30)
        .frame(maxWidth: .infinity, minHeight: 300)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

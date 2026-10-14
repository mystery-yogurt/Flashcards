// Sources/Views/MainView.swift
import SwiftUI
import Charts

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("Статистика за неделю")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        Chart(viewModel.weeklyStats) { stat in
                            BarMark(
                                x: .value("День", stat.day),
                                y: .value("Слова", stat.learnedWords)
                            )
                            .foregroundStyle(Color.blue.gradient)
                            .cornerRadius(4)
                        }
                        .frame(height: 200)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading) {
                        Text("Мои словари")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(viewModel.dictionaries) { dict in
                            NavigationLink(destination: DeckView(viewModel: DeckViewModel(dictionary: dict))) {
                                HStack {
                                    Circle()
                                        .fill(Color(hex: dict.colorHex) ?? Color.blue)
                                        .frame(width: 40, height: 40)
                                        .overlay(Text(String(dict.name.prefix(1))).foregroundColor(.white))
                                    
                                    VStack(alignment: .leading) {
                                        Text(dict.name)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.primary)
                                        Text("\(dict.wordsCount) слов")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(12)
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    Button(action: {
                        viewModel.startSession()
                    }) {
                        Text("Начать сессию повторений")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                .padding(.vertical)
            }
            .navigationTitle("Тренажер слов")
        }
    }
}

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        self.init(red: Double((rgb & 0xFF0000) >> 16) / 255.0,
                  green: Double((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: Double(rgb & 0x0000FF) / 255.0)
    }
}

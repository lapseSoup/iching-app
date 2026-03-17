import SwiftUI
import SwiftData

struct DivineView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var showingSettings: Bool
    @State private var viewModel: DivineViewModel
    @State private var showingMethodPicker = false
    @State private var navigateToReading: Reading?

    init(viewModel: DivineViewModel = DivineViewModel(), showingSettings: Binding<Bool> = .constant(false)) {
        _viewModel = State(initialValue: viewModel)
        _showingSettings = showingSettings
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient.zenGradient
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 32) {
                        headerSection
                        
                        if viewModel.state == .idle {
                            questionSection
                            methodSection
                            startButton
                        } else if viewModel.state == .flipping {
                            coinFlipSection
                        } else if viewModel.state == .complete {
                            resultPreview
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Divine")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showingSettings = true } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .navigationDestination(item: $navigateToReading) { reading in
                ReadingDetailView(reading: reading)
            }
        }
    }
    
    // MARK: - Header
    
    private var headerSection: some View {
        VStack(spacing: 8) {
            Text("易經")
                .font(.largeTitle)
            
            Text("The Book of Changes")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 20)
    }
    
    // MARK: - Question Input
    
    private var questionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Your Question", systemImage: "questionmark.circle")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            TextField("What guidance do you seek?", text: $viewModel.question, axis: .vertical)
                .textFieldStyle(.plain)
                .font(.body)
                .lineLimit(3...6)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.cardBackground)
                )
        }
    }
    
    // MARK: - Method Selection
    
    private var methodSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Method", systemImage: "sparkles")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            HStack(spacing: 12) {
                methodButton(method: .coinFlip, icon: "circle.circle", title: "Coin Flip")
                methodButton(method: .manual, icon: "hand.tap", title: "Manual")
            }
        }
    }
    
    private func methodButton(method: ReadingMethod, icon: String, title: String) -> some View {
        Button {
            viewModel.selectedMethod = method
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                Text(title)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(viewModel.selectedMethod == method ?
                          Color.accentColor.opacity(0.15) :
                          Color.cardBackground)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(viewModel.selectedMethod == method ?
                            Color.accentColor : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(title) method")
        .accessibilityAddTraits(viewModel.selectedMethod == method ? .isSelected : [])
    }
    
    // MARK: - Start Button
    
    private var startButton: some View {
        Button {
            if viewModel.selectedMethod == .manual {
                showingMethodPicker = true
            } else {
                viewModel.startReading()
            }
        } label: {
            HStack {
                Image(systemName: "sparkles")
                Text("Begin Reading")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .padding(.top, 20)
        .sheet(isPresented: $showingMethodPicker) {
            ManualEntryView(viewModel: viewModel)
        }
    }
    
    // MARK: - Coin Flip Section
    
    private var coinFlipSection: some View {
        VStack(spacing: 24) {
            Text("Line \(viewModel.currentLine) of 6")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            // Current lines display
            HexagramBuildingView(lines: viewModel.completedLines)
                .frame(height: 200)
            
            // Coin display
            CoinFlipView(
                coins: viewModel.currentCoins,
                isFlipping: viewModel.isFlipping,
                onFlip: { viewModel.flipCoins() }
            )
            
            if viewModel.canProceed {
                Button("Continue") {
                    viewModel.proceedToNextLine()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(.vertical, 40)
    }
    
    // MARK: - Result Preview
    
    private var resultPreview: some View {
        VStack(spacing: 24) {
            if let hexagram = viewModel.primaryHexagram {
                VStack(spacing: 16) {
                    HexagramView(hexagram: hexagram, changingLines: viewModel.changingLinePositions)
                        .frame(height: 180)
                    
                    Text(hexagram.englishName)
                        .font(.title2.weight(.semibold))
                    
                    Text("\(hexagram.chineseName) • \(hexagram.pinyin)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Button {
                    saveAndViewReading()
                } label: {
                    HStack {
                        Image(systemName: "arrow.right")
                        Text("View Full Reading")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                
                Button("Start New Reading") {
                    viewModel.reset()
                }
                .foregroundStyle(.secondary)
            }
        }
    }
    
    private func saveAndViewReading() {
        let reading = Reading(
            question: viewModel.question,
            lines: viewModel.completedLines,
            method: viewModel.selectedMethod
        )
        modelContext.insert(reading)
        
        navigateToReading = reading
        viewModel.reset()
    }
}

#Preview {
    DivineView()
        .modelContainer(for: [Reading.self], inMemory: true)
}

import SwiftUI

struct ManualEntryView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: DivineViewModel
    
    @State private var lines: [LineValue] = Array(repeating: .youngYang, count: 6)
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Enter your coin results")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                VStack(spacing: 16) {
                    ForEach((0..<6).reversed(), id: \.self) { index in
                        lineRow(index: index)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.cardBackground)
                )
                
                legendView
                
                Spacer()
            }
            .padding()
            .navigationTitle("Manual Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        viewModel.setManualLines(lines)
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func lineRow(index: Int) -> some View {
        HStack {
            Text("Line \(index + 1)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(width: 60, alignment: .leading)
            
            Picker("Line \(index + 1)", selection: $lines[index]) {
                ForEach(LineValue.allCases, id: \.self) { value in
                    Text(labelFor(value))
                        .tag(value)
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
    private func labelFor(_ value: LineValue) -> String {
        switch value {
        case .oldYin: return "6 ⚋○"
        case .youngYang: return "7 ⚊"
        case .youngYin: return "8 ⚋"
        case .oldYang: return "9 ⚊○"
        }
    }
    
    private var legendView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Legend")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            
            Group {
                HStack(spacing: 8) {
                    Text("6")
                        .fontWeight(.semibold)
                    Text("Old Yin (changing) - 3 tails")
                }
                HStack(spacing: 8) {
                    Text("7")
                        .fontWeight(.semibold)
                    Text("Young Yang - 2 tails, 1 head")
                }
                HStack(spacing: 8) {
                    Text("8")
                        .fontWeight(.semibold)
                    Text("Young Yin - 1 tail, 2 heads")
                }
                HStack(spacing: 8) {
                    Text("9")
                        .fontWeight(.semibold)
                    Text("Old Yang (changing) - 3 heads")
                }
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.tertiaryBackground)
        )
    }
}

#Preview {
    ManualEntryView(viewModel: DivineViewModel())
}

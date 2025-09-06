import SwiftUI

// MARK: - PlaceholderScaffold
struct PlaceholderScaffold<Content: View, T>: View {
    let toolbarConfig: QuizAppToolbar
    let uiState: QuizAppUIState<T>
    let onRetryClicked: () -> Void
    let content: (T) -> Content   // only pass the success data

    var body: some View {
        VStack(spacing: 0) {
            QuizAppTopAppBar(toolbarConfig: toolbarConfig)

            Group {
                switch uiState {
                case .loading:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .success(let data):
                    content(data)   // <-- success closure gets exactly 1 argument: T
                case .error(let message):
                    VStack(spacing: 16) {
                        Text(message)
                        Button("Retry", action: onRetryClicked)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .padding()
        }
    }
}

// MARK: - Loading View
struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
    }
}

// MARK: - Error View
struct ErrorView: View {
    let message: String
    let onRetryClicked: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Failed to load data. Please try again.")
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: onRetryClicked) {
                HStack {
                    Text("Retry")
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 18))
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
    }
}

// MARK: - Preview
struct PlaceholderScaffold_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderScaffold(
            toolbarConfig: QuizAppToolbar(title: "Quiz App"),
            uiState: QuizAppUIState<String>.error("Network Error"),
            onRetryClicked: { print("Retry tapped") }
        ) { data in  // only one parameter
            Text("Success with data: \(data)")
                .padding()
        }
    }
}

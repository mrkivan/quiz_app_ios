import SwiftUI
import Combine

struct QuizSetScreen: View {
    var quizSetData: QuizSetScreenData?
    @Binding var path: [AppDestination]
    
    @StateObject var viewModel: QuizSetViewModel = QuizSetViewModel()
    @State private var cancellables = Set<AnyCancellable>()
    
    
    var body: some View {
        PlaceholderScaffold(
            toolbarConfig: QuizAppToolbar(title: quizSetData?.quizSetTitle ?? ""),
            uiState: viewModel.state,
            onRetryClicked: {
                viewModel.handleIntent(.loadQuizSet(quizTopic: quizSetData?.quizTopic))
            }
        ) { quizSetData in
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(quizSetData?.sections ?? [], id: \.fileName) { section in
                        QuizSetScreenItem(
                            quizSetItemData: section,
                            onItemClick: {
                                viewModel.handleIntent(.navigateToQuiz(data: section))
                            },
                            navigateToResultView: { fileName in
                                print("Navigate to result for: \(fileName)")
                            }
                        )
                    }
                }
                .padding(16)
            }
        }
        .onAppear {
            // Load quiz set
            viewModel.handleIntent(.loadQuizSet(quizTopic: quizSetData?.quizTopic))
            
            // Subscribe to navigation events
            viewModel.navigationEvents
                .sink { event in
                    switch event {
                    case .navigateToQuiz(let data):
                        if !path.contains(.quizScreen(quizData: data)) {
                            path.append(.quizScreen(quizData: data))
                        }
                    }
                }
                .store(in: &cancellables)
        }
        .ignoresSafeArea(edges: .top)
    }
}

import SwiftUI
import Resolver
import Combine

struct DashboardView: View {
    @State private var path: [AppDestination] = []
    
    @StateObject var viewModel: DashboardViewModel = DashboardViewModel()
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        NavigationStack(path: $path) {
            PlaceholderScaffold(
                toolbarConfig: QuizAppToolbar(title: "QuizMaster"),
                uiState: viewModel.state,
                onRetryClicked: {
                    viewModel.handleIntent(.loadDashboard)
                }
            ) { dashboardData in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(dashboardData.items, id: \.sectionId) { item in
                            DashboardScreenItem(item: item) {
                                viewModel.handleIntent(.navigateToQuizSets(item))
                            }
                        }
                    }
                    .padding(16)
                }
            }
            .onAppear {
                // Equivalent of `loadData()`
                viewModel.handleIntent(.loadDashboard)
                
                // Equivalent of Kotlin's `collect` from Flow
                viewModel.navigationEvents
                    .sink { event in
                        switch event {
                        case .navigateToQuizSets(let item):
                            let itemData = QuizSetScreenData(quizTopic: item.topic, quizSetTitle: item.title)
                            
                            if !path.contains(.quizSet(quizSetData: itemData)) {
                                path.append(.quizSet(quizSetData: itemData))
                            }
                            print("Navigate to quiz sets: \(item.title)")
                            // Integrate NavigationStack navigation here
                        }
                    }
                    .store(in: &cancellables)
            }
            .navigationDestination(for: AppDestination.self) { destination in
                switch destination {
                case .quizSet(let quizSetData):
                    QuizSetScreen(quizSetData: quizSetData, path: $path)
                case .quizScreen(let quizData):
                    QuizScreenView(quizScreenData:quizData , quizId: -1, path: $path)
                case .resultScreen(let key):
                    ResultScreenView(key: key, path: $path)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}

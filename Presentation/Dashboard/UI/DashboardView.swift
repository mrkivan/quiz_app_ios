import SwiftUI
import Resolver
import Combine

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel = DashboardViewModel()
    @State private var cancellables = Set<AnyCancellable>()

    var body: some View {
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
                        print("Navigate to quiz sets: \(item.title)")
                        // Integrate NavigationStack navigation here
                    }
                }
                .store(in: &cancellables)
        }
        .ignoresSafeArea(edges: .top)
    }
}

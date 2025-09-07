import SwiftUI

// MARK: - Toolbar Models
struct QuizAppToolbar {
    var title: String = ""
    var navigationIcon: String? = nil                 // SF Symbol name
    var navigationIconContentDescription: String? = nil
    var onNavigationClick: (() -> Void)? = nil
    var actions: [ToolbarAction] = []
}

struct ToolbarAction {
    var icon: String                                  // SF Symbol name
    var contentDescription: String
    var onClick: () -> Void
}

// MARK: - Top App Bar
import SwiftUI

struct QuizAppTopAppBar: View {
    let toolbarConfig: QuizAppToolbar

    var body: some View {
        HStack {
            // Navigation Icon
            if let navIcon = toolbarConfig.navigationIcon {
                Button(action: { toolbarConfig.onNavigationClick?() }) {
                    Image(systemName: navIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
            }

            // Title
            Text(toolbarConfig.title)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .center) // ✅ center align

            // Actions
            HStack(spacing: 16) {
                ForEach(toolbarConfig.actions, id: \.contentDescription) { action in
                    Button(action: action.onClick) {
                        Image(systemName: action.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0) // add status bar height
        .padding(.bottom, 12)
        .background(Color.blue)
        .edgesIgnoringSafeArea(.top) // extend behind status bar
    }
}

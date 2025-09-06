import SwiftUI

struct ConfirmDialog: View {
    let title: String
    let message: String
    let confirmButtonLabel: String
    let onConfirm: () -> Void
    let onCancel: (() -> Void)?
    
    @Binding var showDialog: Bool
    
    var body: some View {
        EmptyView()
            .alert(title, isPresented: $showDialog) {
                Button(confirmButtonLabel) {
                    showDialog = false
                    onConfirm()
                }
                Button("Cancel", role: .cancel) {
                    showDialog = false
                    onCancel?()
                }
            } message: {
                Text(message)
            }
    }
}

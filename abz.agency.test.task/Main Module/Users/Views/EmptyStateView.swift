import SwiftUI

struct EmptyStateView: View {
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 25) {
            emptyImage
            emptyMessage
        }
        .padding()
    }
}

// MARK: - Subviews

private extension EmptyStateView {
    
    var emptyImage: some View {
        Image(.empty)
    }
    
    var emptyMessage: some View {
        Text("There are no users yet")
            .font(font: .nunitoSans(.regular), size: 20, color: Color(.black87), alignment: .center)
    }
}

#Preview {
    EmptyStateView()
}

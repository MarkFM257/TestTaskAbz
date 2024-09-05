import SwiftUI

struct LaunchView: View {
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            backgroundColor
            logoImage
        }
       
    }
}

#Preview {
    LaunchView()
}

// MARK: - Subviews

private extension LaunchView {
    
    var backgroundColor: some View {
        Color(.appPrimary).ignoresSafeArea()
    }
    
    var logoImage: some View {
        Image(.logo)
    }
}

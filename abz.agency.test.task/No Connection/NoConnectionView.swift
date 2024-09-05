import SwiftUI

struct NoConnectionView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var noConnectionManager: NoConnectionManager
    let tryAgainAction: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 25) {
            image
            title
            tryAgain
        }
    }
}

// MARK: - Extension

private extension NoConnectionView {
    
    var image: some View {
        Image("noConnection")
    }
    
    var title: some View {
        Text("There is no internet connection")
            .font(font: .nunitoSans(.regular), size: 20, color: .black87, alignment: .center)
    }
    
    var tryAgain: some View {
        PrimaryButton(type: .tryAgain, isActive: true) {
            noConnectionManager.checkConnection()
        }
    }
    
}

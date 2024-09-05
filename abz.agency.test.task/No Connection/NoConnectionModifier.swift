import SwiftUI

struct NoConnectionModifier: ViewModifier {
    @EnvironmentObject var noConnectionManager: NoConnectionManager
        
        func body(content: Content) -> some View {
            ZStack {
                if noConnectionManager.isConnected {
                    content
                } else {
                    NoConnectionView {
                        
                    }
                }
            }
        }
}

extension View {
    func noConnection() -> some View {
        self.modifier(NoConnectionModifier())
    }
}

import SwiftUI

enum RouterState {
    case loading
    case content
}

struct RouterView: View {
    @State private var currentState: RouterState = .loading

    var body: some View {
        VStack {
            switch currentState {
            case .loading:
                LaunchView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                currentState = .content
                            }
                        }
                    }
            case .content:
                ContentView()
            }
        }
    }
}

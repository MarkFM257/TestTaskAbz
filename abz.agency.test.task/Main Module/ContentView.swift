import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var selectedTab: Tab = .users
    @StateObject private var signUpViewModel = SignUpViewModel(signUpService: SignUpService(networkManager: NetworkManager()))
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                switch selectedTab {
                case .users:
                    UsersView()
                case .signUp:
                    SignUpView(viewModel: signUpViewModel)
                }
                TabBar(selectedTab: $selectedTab)
                    .frame(height: 60)
            }
            
            if signUpViewModel.isShowSuccesRegister || signUpViewModel.isShowFailureRegister {
                ResultView(
                    type: signUpViewModel.isShowSuccesRegister ? .success : .failure,
                    message: signUpViewModel.resultMessage,
                    isShowResult: signUpViewModel.isShowSuccesRegister ? $signUpViewModel.isShowSuccesRegister : $signUpViewModel.isShowFailureRegister
                ) {
                    if signUpViewModel.isShowSuccesRegister {
                        signUpViewModel.isShowSuccesRegister.toggle()
                    } else {
                        signUpViewModel.isShowFailureRegister.toggle()
                    }
                }
                .transition(.opacity)
                .animation(.easeInOut, value: signUpViewModel.isShowSuccesRegister || signUpViewModel.isShowFailureRegister)
            }
        }
        .noConnection()
        .ignoresSafeArea(.keyboard, edges: .all)
    }
}
#Preview {
    ContentView()
}


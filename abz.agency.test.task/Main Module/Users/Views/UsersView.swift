import SwiftUI

struct UsersView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = UsersViewModel(networkManager: NetworkManager())

     // MARK: - Body

    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading: emptyView
            case .success(let users), .loadingNextPage(let users): getUsersList(users)
            case .failure(let errorMessage): failure(message: errorMessage)
            }
        }.onAppear {
            viewModel.fetchUsers()
        }
    }
}


// MARK: - Extension

private extension UsersView {
    
    var header: some View {
        HeaderView(type: .get)
            .padding(.top)
    }
    
    var emptyView: some View {
        VStack {
            header
            Spacer()
            EmptyStateView()
            Spacer()
            Color.clear.frame(height: 50)
        }
    }
    
    func failure(message: String) -> some View {
        VStack {
            header
            Spacer()
            Text(message)
                .font(font: .nunitoSans(.regular), size: 14, color: Color(.error), alignment: .center)
                .padding()
        }
    }
    
    func getUsersList(_ users: [User]) -> some View {
        VStack(spacing: 0) {
            header
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(users) { user in
                        UserItem(user: user)
                            .padding(.horizontal)
                            .onAppear {
                                viewModel.loadNextPageIfNeeded(currentUser: user)
                            }
                    }
                    
                    if case .loadingNextPage = viewModel.state {
                        ProgressView("Loading more users...")
                            .padding()
                    }
                }
                .padding(.top, 16)
            }
        }
    }

}

#Preview {
    UsersView()
}


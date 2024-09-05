import SwiftUI
import Combine

enum ViewState {
    case loading
    case success([User])
    case failure(String)
    case loadingNextPage([User])
}

class UsersViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var state: ViewState = .loading
    @Published private(set) var currentPage: Int = 1
    @Published private(set) var totalPages: Int = 1
    
    private var cancellable: AnyCancellable?
    private let networkManager: NetworkManaging
    private var cache: [Int: [User]] = [:]
    private let cacheLimit = 100
    private let usersPerPage = 6
    
    // MARK: - Initialization
    
    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    // MARK: - Functions
    
    // MARK: Public
    
    public func loadNextPageIfNeeded(currentUser user: User) {
        if case .success(let users) = state, let lastUser = users.last {
            if lastUser.id == user.id && currentPage < totalPages {
                fetchUsers(page: currentPage + 1)
            }
        }
    }
    
    public func fetchUsers(page: Int = 1) {
        if let cachedUsers = cache[page] {
            handleSuccess(users: cachedUsers, page: page, totalPages: totalPages, isCached: true)
            return
        }
        
        updateStateForLoading(page: page)
        
        let urlString = "https://frontend-test-assignment-api.abz.agency/api/v1/users?page=\(page)&count=\(usersPerPage)"
        
        cancellable = networkManager.request(urlString, method: "GET", parameters: nil, headers: nil)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .failure("Failed to load users: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (userResponse: UserResponse) in  // Явное указание типа
                self?.cacheUsers(users: userResponse.users, page: userResponse.page)
                self?.handleSuccess(users: userResponse.users, page: userResponse.page, totalPages: userResponse.totalPages)
            })
    }
    
    // MARK: Private
    
    
    private func cacheUsers(users: [User], page: Int) {
        if cache.keys.count >= cacheLimit {
            cache.removeValue(forKey: cache.keys.first!)
        }
        cache[page] = users
    }
    
    private func handleSuccess(users: [User], page: Int, totalPages: Int, isCached: Bool = false) {
        self.currentPage = page
        self.totalPages = totalPages
        
        let sortedUsers = users.sorted { $0.registrationTimestamp > $1.registrationTimestamp }
        
        if page == 1 || isCached {
            self.state = .success(sortedUsers)
        } else if case .loadingNextPage(let currentUsers) = self.state {
            self.state = .success(currentUsers + sortedUsers)
        }
    }
    
    private func updateStateForLoading(page: Int) {
        if page == 1 {
            self.state = .loading
        } else if case .success(let currentUsers) = state {
            self.state = .loadingNextPage(currentUsers)
        }
    }
    
    
}

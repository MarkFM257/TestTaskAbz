import Combine
import UIKit

class SignUpService {
    
    // MARK: - Properties
    
    private let networkManager: NetworkManaging
    
    // MARK: - Initialization

    init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }
    
    // MARK: - Functions
    
    func fetchPositions() -> AnyPublisher<PositionsResponse, NetworkError> {
        return networkManager.request("https://frontend-test-assignment-api.abz.agency/api/v1/positions", method: "GET", parameters: nil, headers: nil)
            .handleResponse()
    }

    func signUp(registrationInfo: UserRegistrationInfo, formattedPhone: String, token: String, selectedImage: UIImage?, selectedPositionId: Int?) -> AnyPublisher<RegistrationResponse, NetworkError> {
        let boundary = UUID().uuidString
        let formData = FormDataBuilder.createFormData(boundary: boundary, registrationInfo: registrationInfo, formattedPhone: formattedPhone, positionId: selectedPositionId, image: selectedImage)
        return networkManager.registerUser(boundary: boundary, formData: formData, token: token)
            .handleResponse()
    }

    func fetchToken() -> AnyPublisher<TokenResponse, NetworkError> {
        return networkManager.fetchToken().handleResponse()
    }
}

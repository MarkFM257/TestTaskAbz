import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case serverError(String)
    case requestFailed(String)
}

protocol NetworkManaging {
    func request<T: Decodable>(_ endpoint: String, method: String, parameters: [String: Any]?, headers: [String: String]?) -> AnyPublisher<T, NetworkError>
    func fetchToken() -> AnyPublisher<TokenResponse, NetworkError>
    func registerUser(boundary: String, formData: Data, token: String) -> AnyPublisher<RegistrationResponse, NetworkError>
}

class NetworkManager: NetworkManaging {
    
    func request<T: Decodable>(_ endpoint: String, method: String = "GET", parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> AnyPublisher<T, NetworkError> {
        
        guard let url = URL(string: endpoint) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        if method == "POST", let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                return Fail(error: NetworkError.requestFailed("Invalid parameters")).eraseToAnyPublisher()
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { _ in NetworkError.serverError("Network request failed") }
            .flatMap { data, response -> AnyPublisher<T, NetworkError> in
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    return Just(decodedResponse)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } catch {
                    return Fail(error: NetworkError.decodingError).eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchToken() -> AnyPublisher<TokenResponse, NetworkError> {
        return request("https://frontend-test-assignment-api.abz.agency/api/v1/token", method: "GET", parameters: nil, headers: nil)
    }
    
    func registerUser(boundary: String, formData: Data, token: String) -> AnyPublisher<RegistrationResponse, NetworkError> {
        var request = URLRequest(url: URL(string: "https://frontend-test-assignment-api.abz.agency/api/v1/users")!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Token")
        request.httpBody = formData
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { _ in NetworkError.serverError("Registration failed") }
            .flatMap { data, response -> AnyPublisher<RegistrationResponse, NetworkError> in
                do {
                    let decodedResponse = try JSONDecoder().decode(RegistrationResponse.self, from: data)
                    return Just(decodedResponse)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } catch {
                    return Fail(error: NetworkError.decodingError).eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}



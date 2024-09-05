import Combine
import Foundation

extension Publisher {
    func handleResponse() -> AnyPublisher<Output, Failure> {
        return self
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

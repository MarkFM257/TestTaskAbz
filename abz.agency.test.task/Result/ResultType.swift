import Foundation

enum ResultType: String {
    case success = "success"
    case failure = "failure"
    
    var imageName: String {
        rawValue
    }
    
    var buttonType: PrimaryButtonType {
        switch self {
        case .success:
            return .gotIt
        case .failure:
            return .tryAgain
        }
    }
}

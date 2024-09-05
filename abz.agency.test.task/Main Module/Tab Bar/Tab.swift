import SwiftUI

enum Tab: String, CaseIterable {
    case users = "Users"
    case signUp = "Sign Up"
    
    var iconName: String {
        switch self {
        case .users:
            return "person.3.sequence.fill"
        case .signUp:
            return "person.crop.circle.badge.plus"
        }
    }
}

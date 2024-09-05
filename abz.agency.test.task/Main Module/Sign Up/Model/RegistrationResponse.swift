import Foundation

struct RegistrationResponse: Decodable {
    let success: Bool
    let message: String
    let userId: Int?
}

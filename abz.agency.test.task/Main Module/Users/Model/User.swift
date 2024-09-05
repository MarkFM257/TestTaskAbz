import Foundation

struct UserResponse: Codable {
    let success: Bool
    let totalPages: Int
    let totalUsers: Int
    let count: Int
    let page: Int
    let links: Links
    let users: [User]
    
    struct Links: Codable {
        let nextUrl: String?
        let prevUrl: String?
        
        enum CodingKeys: String, CodingKey {
            case nextUrl = "next_url"
            case prevUrl = "prev_url"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case success, count, page, links, users
        case totalPages = "total_pages"
        case totalUsers = "total_users"
    }
}

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let position: String
    let positionId: Int
    let registrationTimestamp: Int
    let photo: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, position
        case positionId = "position_id"
        case registrationTimestamp = "registration_timestamp"
        case photo
    }
}

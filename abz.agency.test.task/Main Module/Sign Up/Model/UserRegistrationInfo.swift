import UIKit

struct UserRegistrationInfo {
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    var position: String = ""
    
    mutating func clearInfo() {
        name = ""
        email = ""
        phone = ""
        position = ""
    }
}

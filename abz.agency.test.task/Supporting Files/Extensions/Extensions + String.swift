import Foundation

extension String {
    func convertToPhoneNumber() -> String {
        var cleanedPhoneNumber = self.replacingOccurrences(of: "[\\s\\-()]", with: "", options: .regularExpression)
        if cleanedPhoneNumber.hasPrefix("+38") {
            cleanedPhoneNumber = cleanedPhoneNumber.replacingOccurrences(of: "+3800", with: "+380")
        }
        return cleanedPhoneNumber
    }
}

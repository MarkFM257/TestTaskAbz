import Foundation

class Validator {
    
    func validateName(_ name: String) -> CustomTextField.FieldState {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let nameLength = trimmedName.count
        
        if nameLength < 2 {
            return .error("Username should contain at least 2 characters")
        } else if nameLength > 60 {
            return .error("Username should not exceed 60 characters")
        } else {
            return .normal
        }
    }
    
    func validateEmail(_ email: String) -> CustomTextField.FieldState {
        if isValidEmail(email) {
            return .normal
        } else {
            return .error("Invalid email format")
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^(?:(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    func validatePhone(_ phone: String) -> CustomTextField.FieldState {
        let phoneRegEx = "^\\+38 \\(\\d{3}\\) \\d{3} - \\d{2} - \\d{2}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        if phonePredicate.evaluate(with: phone) {
            return .normal
        } else {
            return .error("Phone must be in the format +38 (XXX) XXX - XX - XX")
        }
    }
}

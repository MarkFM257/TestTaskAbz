import UIKit

class ValidationService {
    
    private let validator = Validator()

    func validateFields(registrationInfo: UserRegistrationInfo, selectedImage: UIImage?) -> (nameState: CustomTextField.FieldState, emailState: CustomTextField.FieldState, phoneState: CustomTextField.FieldState, photoState: UploadPhotoState) {
        let nameState = validator.validateName(registrationInfo.name)
        let emailState = validator.validateEmail(registrationInfo.email.lowercased())
        let phoneState = validator.validatePhone(registrationInfo.phone)
        let photoState: UploadPhotoState = (selectedImage == nil) ? .error("Photo is required") : .normal
        return (nameState, emailState, phoneState, photoState)
    }
}

import SwiftUI
import Combine

enum RegistrationResult {
    case success(message: String)
    case failure(message: String)
}

class SignUpViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published public var registrationInfo = UserRegistrationInfo()
    @Published public var photoState: UploadPhotoState = .normal
    @Published public var selectedImage: UIImage? = nil
    @Published public var isShowingPhotoOptions = false
    @Published public var isShowingImagePicker = false
    @Published public var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published public var selectedPositionId: Int?
    @Published public var isShowSuccesRegister = false
    @Published public var isShowFailureRegister = false
    public var resultMessage = ""
    
    @Published private(set) var nameState: CustomTextField.FieldState = .normal
    @Published private(set) var emailState: CustomTextField.FieldState = .normal
    @Published private(set) var phoneState: CustomTextField.FieldState = .normal
    @Published private(set) var positions: [UserPosition] = []
    
    private var formattedPhoneForRequest: String = ""
    private var cancellable = Set<AnyCancellable>()
    
    private let validationService = ValidationService()
    private let signUpService: SignUpService
    
    public var isFormValid: Bool {
        return !registrationInfo.name.isEmpty && !registrationInfo.email.isEmpty && !registrationInfo.phone.isEmpty && selectedPositionId != nil
    }
    
    
    // MARK: - Initialization
    
    init(signUpService: SignUpService) {
        self.signUpService = signUpService
    }
    
    // MARK: - Functions
    
    // MARK: Public
    
    public func signUp() {
        validateFields()
        if isFormValid {
            signUpService.fetchToken()
                .sink(receiveCompletion: handleCompletion, receiveValue: { [weak self] tokenResponse in
                    guard let self = self else { return }
                    self.formattedPhoneForRequest = self.registrationInfo.phone.convertToPhoneNumber()
                    self.performRegistration(token: tokenResponse.token)
                })
                .store(in: &cancellable)
        }
    }
    
    public func fetchPositions() {
        signUpService.fetchPositions()
            .sink(receiveCompletion: handleCompletion, receiveValue: { [weak self] response in
                self?.positions = response.positions
            })
            .store(in: &cancellable)
    }
    
    // MARK: Private
    
    private func validateFields() {
        let validationResult = validationService.validateFields(registrationInfo: registrationInfo, selectedImage: selectedImage)
        nameState = validationResult.nameState
        emailState = validationResult.emailState
        phoneState = validationResult.phoneState
        photoState = validationResult.photoState
    }
    
    private func performRegistration(token: String) {
        signUpService.signUp(registrationInfo: registrationInfo, formattedPhone: formattedPhoneForRequest, token: token, selectedImage: selectedImage, selectedPositionId: selectedPositionId)
            .sink(receiveCompletion: handleCompletion, receiveValue: { response in
                switch response.success {
                case true:
                    self.showResult(.success(message: response.message))
                case false:
                    self.showResult(.failure(message: response.message))
                }
            })
            .store(in: &cancellable)
    }
    
    private func handleCompletion(_ completion: Subscribers.Completion<NetworkError>) {
        switch completion {
        case .failure(let error):
            print("Error occurred: \(error)")
        case .finished:
            break
        }
    }
    
    private func showResult(_ result: RegistrationResult) {
        switch result {
        case .success(let message):
            self.resultMessage = message
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.clearTextFields()
                self.isShowSuccesRegister.toggle()
            }
        case .failure(let message):
            self.resultMessage = message
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isShowFailureRegister.toggle()
            }
        }
    }
    
    private func clearTextFields() {
        registrationInfo.clearInfo()
        nameState = .normal
        emailState = .normal
        phoneState = .normal
        photoState = .normal
    }
    
}

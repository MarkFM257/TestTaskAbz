import SwiftUI

struct SignUpView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: SignUpViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            header
            formContent
        }
        .onTapGesture { self.hideKeyboard() }
        .onAppear(perform: viewModel.fetchPositions)
        .actionSheet(isPresented: $viewModel.isShowingPhotoOptions, content: photoOptionsActionSheet)
        .sheet(isPresented: $viewModel.isShowingImagePicker, content: imagePickerSheet)
    }
}

// MARK: - Extension

private extension SignUpView {
    
    var header: some View {
        HeaderView(type: .post)
            .padding(.top)
    }
    
    var formContent: some View {
        ScrollView {
            VStack(spacing: 16) {
                CustomTextField(
                    text: $viewModel.registrationInfo.name,
                    state: viewModel.nameState,
                    type: .name)
                
                CustomTextField(
                    text: $viewModel.registrationInfo.email,
                    state: viewModel.emailState,
                    type: .email)
                
                CustomTextField(
                    text: $viewModel.registrationInfo.phone,
                    state: viewModel.phoneState,
                    type: .phone)
                    .phoneNumberFormatter(text: $viewModel.registrationInfo.phone)
                
                positionSelection
                uploadPhotoSection
                
                PrimaryButton(type: .signUp, isActive: viewModel.isFormValid) {
                    viewModel.signUp()
                }
                .padding(.top)
            }
            .padding()
        }
    }
    
    var positionSelection: some View {
        PositionSelectionView(selectedPositionId: $viewModel.selectedPositionId, positions: viewModel.positions)
            .padding(.top)
    }
    
    var uploadPhotoSection: some View {
        UploadPhotoView(photoState: $viewModel.photoState) {
            viewModel.isShowingPhotoOptions.toggle()
        }
    }
    
    // MARK: - ActionSheet
    
    func photoOptionsActionSheet() -> ActionSheet {
        ActionSheet(
            title: Text("Choose how you want to add a photo"),
            buttons: [
                .default(Text("Camera")) {
                    viewModel.imagePickerSourceType = .camera
                    viewModel.isShowingImagePicker = true
                },
                .default(Text("Gallery")) {
                    viewModel.imagePickerSourceType = .photoLibrary
                    viewModel.isShowingImagePicker = true
                },
                .cancel()
            ]
        )
    }
    
    func imagePickerSheet() -> some View {
        ImagePicker(image: $viewModel.selectedImage, sourceType: viewModel.imagePickerSourceType)
    }
}

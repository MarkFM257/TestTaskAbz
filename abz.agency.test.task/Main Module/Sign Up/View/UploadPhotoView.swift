import SwiftUI

enum UploadPhotoState: Equatable {
    case normal
    case error(String)
}


struct UploadPhotoView: View {
    @Binding var photoState: UploadPhotoState
    var onUpload: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Upload your photo")
                    .foregroundColor(textColor)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                Spacer()
                Button(action: {
                    onUpload()
                }) {
                    Text("Upload")
                        .font(font: .nunitoSans(.semiBold), size: 16, color: Color(.appSecondary))
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1)
            )
          
            
            if case let .error(errorMessage) = photoState {
                Text(errorMessage)
                    .font(font: .nunitoSans(.regular), size: 14, color: .error)
                    .padding(.horizontal, 20)
            }
        }
    }
    
    private var textColor: Color {
        switch photoState {
        case .normal:
            return Color.borderGray
        case .error:
            return Color.error
        }
    }
    
    private var borderColor: Color {
        switch photoState {
        case .normal:
            return Color.borderGray
        case .error:
            return Color.error
        }
    }
}

#Preview {
    UploadPhotoView(photoState: .constant(.error("Photo is required"))) {
        
    }
}

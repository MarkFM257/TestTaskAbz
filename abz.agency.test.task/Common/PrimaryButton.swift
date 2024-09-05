import SwiftUI

enum PrimaryButtonType: String {
    case tryAgain = "Try again"
    case signUp = "Sign up"
    case gotIt = "Got it"
}

struct PrimaryButton: View {
    
    // MARK: - Properties
    
    let type: PrimaryButtonType
    let isActive: Bool
    let action: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Button(action: action) {
            Text(type.rawValue)
                .font(font: .nunitoSans(.semiBold), size: 18, color: titleColor)
                .frame(width: 140, height: 48)
                .background(backgroundColor)
                .cornerRadius(24)
        }.disabled(!isActive)
    }
    
    // MARK: - Subviews
    
    private var backgroundColor: Color {
        isActive ? Color(.appPrimary) : Color(.buttonGray)
    }
    
    private var titleColor: Color {
        isActive ? Color(.black87) : Color(.black48)
    }
}

#Preview {
    PrimaryButton(type: .gotIt, isActive: false) {
        print("Button tapped!")
    }
}

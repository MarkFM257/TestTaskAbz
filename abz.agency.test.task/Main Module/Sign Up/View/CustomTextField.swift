import SwiftUI

struct CustomTextField: View {
    
    enum FieldType {
        case phone
        case email
        case name
        
        var placeholder: String {
            switch self {
            case .phone:
                return "Phone"
            case .email:
                return "Email"
            case .name:
                return "Your name"
            }
        }
    }
    
    enum FieldState: Equatable {
        case normal
        case error(String)
    }
    
    @Binding var text: String
    let state: FieldState
    let type: FieldType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(type.placeholder, text: $text)
                .padding()
                .background(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(borderColor, lineWidth: 1)
                )
                .keyboardType(keyboardType)
                .onChange(of: text) { newValue in
                    if type == .email {
                        text = newValue.lowercased()
                    }
                }
            
            if case let .error(errorMessage) = state {
                Text(errorMessage)
                    .font(font: .nunitoSans(.regular), size: 12, color: .error)
                    .padding(.horizontal)
            }
            
            if type == .phone && state == .normal {
                Text("+38 (XXX) XXX - XX - XX")
                    .font(font: .nunitoSans(.regular), size: 12, color: .black60)
                    .padding(.horizontal)
            }
        }
        .padding(.vertical, 8)
        
    }
    

    private var backgroundColor: Color {
        switch state {
        case .normal, .error: Color.white
        }
    }
    
    private var borderColor: Color {
        switch state {
        case .normal: Color.borderGray
        case .error: Color.error
        }
    }
    
    private var keyboardType: UIKeyboardType {
        switch type {
        case .phone: .phonePad
        case .email: .emailAddress
        case .name: .default
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}



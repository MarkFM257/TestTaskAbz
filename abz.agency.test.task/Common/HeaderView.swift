import SwiftUI

struct HeaderView: View {
        
    enum HeaderType {
        case get
        case post
        
        var title: String {
            switch self {
            case .get: "Working with GET request"
            case .post: "Working with POST request"
            }
        }
    }
    
    let type: HeaderType
    
     // MARK: - Body
    
    var body: some View {
        Text(type.title)
            .font(font: .nunitoSans(.regular), size: 20, color: Color(.surface), alignment: .center)
            .frame(maxWidth: .infinity, maxHeight: 56)
            .background(Color(.appPrimary))
    }
}

#Preview {
    HeaderView(type: .get)
}

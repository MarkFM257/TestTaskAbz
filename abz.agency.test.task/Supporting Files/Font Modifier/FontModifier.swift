import SwiftUI

struct FontModifier: ViewModifier {
    var font: Font
    var size: CGFloat
    var color: Color
    var alignment: TextAlignment? = .leading
    
    func body(content: Content) -> some View {
        content
            .font(.custom(font.font, size: size))
            .foregroundColor(color)
            .multilineTextAlignment(alignment ?? .leading)
    }
}

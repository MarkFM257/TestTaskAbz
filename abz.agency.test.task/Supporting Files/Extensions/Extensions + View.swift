import SwiftUI
import Combine

extension View {
    func font(font: Font, size: CGFloat, color: Color, alignment: TextAlignment? = .leading) -> some View {
        self.modifier(FontModifier(font: font, size: size, color: color, alignment: alignment))
    }
    func phoneNumberFormatter(text: Binding<String>) -> some View {
        self.modifier(PhoneNumberFormatter(text: text))
    }
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


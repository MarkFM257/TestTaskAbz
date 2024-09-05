import SwiftUI

struct PhoneNumberFormatter: ViewModifier {
    @Binding var text: String
    @State private var previousText: String = ""

    func body(content: Content) -> some View {
        content
            .keyboardType(.phonePad)
            .onChange(of: text) { newValue in
                formatPhoneNumber(newValue)
            }
    }

    private func formatPhoneNumber(_ newValue: String) {
        var digits = newValue.filter { $0.isNumber }

        if digits.hasPrefix("0") && !digits.hasPrefix("38") {
            digits = "38" + digits.dropFirst()
        }

        if digits.hasPrefix("3800") {
            digits = "38" + digits.dropFirst(4)
        }

        var formattedText = "+\(digits.prefix(2))"

        if digits.count > 2 {
            let start = digits.index(digits.startIndex, offsetBy: 2)
            let end = digits.index(start, offsetBy: min(3, digits.count - 2))
            let range = start..<end
            let areaCode = digits[range]
            formattedText = "+\(digits.prefix(2)) (\(areaCode))"
        }

        if digits.count > 5 {
            let start = digits.index(digits.startIndex, offsetBy: 5)
            let end = digits.index(start, offsetBy: min(3, digits.count - 5))
            let range = start..<end
            let secondPart = digits[range]
            formattedText += " \(secondPart)"
        }

        if digits.count > 8 {
            let start = digits.index(digits.startIndex, offsetBy: 8)
            let end = digits.index(start, offsetBy: min(2, digits.count - 8))
            let range = start..<end
            let thirdPart = digits[range]
            formattedText += " - \(thirdPart)"
        }

        if digits.count > 10 {
            let start = digits.index(digits.startIndex, offsetBy: 10)
            let end = digits.index(start, offsetBy: min(2, digits.count - 10))
            let range = start..<end
            let lastPart = digits[range]
            formattedText += " - \(lastPart)"
        }

        if newValue.count < previousText.count {
            previousText = newValue
            return
        }
        
        if text != formattedText {
            text = formattedText
        }

        previousText = text
    }
}


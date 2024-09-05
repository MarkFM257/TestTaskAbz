import SwiftUI

struct ResultView: View {
    
    // MARK: - Properties

    var type: ResultType
    var message: String
    @Binding var isShowResult: Bool
    var action: () -> ()
    
     // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 0) {
                closeButton
                Spacer()
                content(type: type)
                Spacer()
            }
        }
    }
}

// MARK: - Extension

private extension ResultView {
    
    var closeButton: some View {
        HStack {
            Spacer()
            Button {
                isShowResult = false
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.black48)
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal)
    }
    
    func content(type: ResultType) -> some View {
        VStack(spacing: 16) {
            resultImage(named: type.imageName)
            resultTitle(text: message)
            resultButton(for: type.buttonType)
        }
        .padding(.bottom, 70)
    }
    
    func resultImage(named imageName: String) -> some View {
        Image(imageName)
    }
    
    func resultTitle(text: String) -> some View {
        Text(text)
            .font(font: .nunitoSans(.regular), size: 20, color: .black87, alignment: .center)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
    
    func resultButton(for buttonType: PrimaryButtonType) -> some View {
        PrimaryButton(type: buttonType, isActive: true) {
            action()
        }
    }
}

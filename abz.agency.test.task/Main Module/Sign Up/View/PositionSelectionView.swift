import SwiftUI

struct PositionSelectionView: View {
    
    // MARK: - Properties
    
    @Binding var selectedPositionId: Int?
    var positions: [UserPosition]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Select your position")
                .font(font: .nunitoSans(.regular), size: 18, color: .black87)
                .padding(.bottom)

            ForEach(positions) { position in
                HStack(spacing: 17) {
                    ZStack {
                        if selectedPositionId == position.id {
                            ZStack {
                                Circle()
                                    .fill(Color(.appSecondary))
                                    .frame(width: 14, height: 14)
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 6, height: 6)
                            }
                        } else {
                            Circle()
                                .stroke(Color(.borderGray), lineWidth: 1)
                                .frame(width: 14, height: 14)
                        }
                    }
                    .frame(width: 48, height: 48)
                    .contentShape(Rectangle())

                    Text(position.name)
                        .font(font: .nunitoSans(.regular), size: 18, color: .black87)

                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedPositionId = position.id
                }
            }
        }
        .padding(.vertical, 8)
    }
}

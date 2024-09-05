import SwiftUI

struct UserItem: View {
    
    // MARK: - Properties
    
    let user: User
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            userPhoto
            VStack(alignment: .leading, spacing: 8) {
                userInfo
                userContactInfo
                Divider()
                    .background(Color(.bottomSide))
                    .padding(.top, 12)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    UserItem(user: User(
        id: 1,
        name: "Malcolm Bailey",
        email: "jany_murazik51@hotmail.com",
        phone: "+38 (098) 278 76 24",
        position: "Backend developer",
        positionId: 1,
        registrationTimestamp: 1,
        photo: "https://frontend-test-assignment-api.abz.agency/images/users/66d5aedb90e1223088.jpg"))
}

// MARK: - Subviews

private extension UserItem {
    
    var userPhoto: some View {
        AsyncImage(url: URL(string: user.photo)) { image in
            image.resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 50, height: 50)
        .clipShape(Circle())
    }
    
    var userInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            userName
            userPosition
        }
    }
    
    var userContactInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            userEmail
            userPhone
        }
    }
    
    var userName: some View {
        Text(user.name)
            .font(font: .nunitoSans(.regular), size: 18, color: Color(.black60), alignment: .leading)
    }
    
    var userPosition: some View {
        Text(user.position)
            .font(font: .nunitoSans(.regular), size: 14, color: Color(.black60), alignment: .leading)
    }
    
    var userEmail: some View {
        Text(user.email)
            .font(font: .nunitoSans(.regular), size: 14, color: Color(.black87), alignment: .leading)
    }
    
    var userPhone: some View {
        Text(user.phone)
            .font(font: .nunitoSans(.regular), size: 14, color: Color(.black87), alignment: .leading)
    }
}

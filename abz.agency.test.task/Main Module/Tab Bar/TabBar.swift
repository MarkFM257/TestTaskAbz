
import SwiftUI

struct TabBar: View {
    
    // MARK: - Properties
    
    @Binding var selectedTab: Tab
    private let tabs: [Tab] = Tab.allCases
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            backgroundView
            tabItems
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Helpers
    
    private func tabTextColor(for tab: Tab) -> Color {
        selectedTab == tab ? Color(.appSecondary) : Color(.black60)
    }
}

#Preview {
    ContentView()
}

// MARK: - Extension

private extension TabBar {
    
    var backgroundView: some View {
        Color(.tabbarBg)
            .ignoresSafeArea()
    }
    
    var tabItems: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabItem(for: tab)
            }
        }
    }
    
    func tabItem(for tab: Tab) -> some View {
        HStack {
            Image(systemName: tab.iconName)
                .font(font: .nunitoSans(.semiBold), size: 16, color: tabTextColor(for: tab))
            Text(tab.rawValue)
                .font(font: .nunitoSans(.semiBold), size: 16, color: tabTextColor(for: tab))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                selectedTab = tab
            }
        }
        .frame(maxWidth: .infinity)
    }
}


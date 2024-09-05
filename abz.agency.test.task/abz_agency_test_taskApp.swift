import SwiftUI

@main
struct abz_agency_test_taskApp: App {
    @StateObject private var noConnectionManager = NoConnectionManager()
    var body: some Scene {
        WindowGroup {
            RouterView()
                .environmentObject(noConnectionManager)
        }
    }
}

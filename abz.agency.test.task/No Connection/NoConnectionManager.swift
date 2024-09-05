import SwiftUI
import Network

class NoConnectionManager: ObservableObject {
    private var monitor = NWPathMonitor()
    private let queue = DispatchQueue.global()
    
    @Published var isConnected: Bool = true
    
    init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    func checkConnection() {
        DispatchQueue.main.async {
            self.isConnected = self.monitor.currentPath.status == .satisfied
        }
    }
}

import Foundation

enum Position: String, CaseIterable, Identifiable {
    case frontend = "Frontend"
    case backend = "Backend"
    case design = "Design"
    case qa = "QA"
    
    var id: String? { self.rawValue }
}

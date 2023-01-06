import Foundation

enum EntityType: String, Identifiable, CaseIterable {
    case all
    case album
    case song
    
    var id: String {
        self.rawValue
    }
    
    func name() -> String {
        switch self {
            case .all:
                return "All"
            case .album:
                return "Albums"
            case .song:
                return "Songs"
        }
    }
}

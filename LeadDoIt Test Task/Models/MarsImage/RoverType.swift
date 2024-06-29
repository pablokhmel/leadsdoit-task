import Foundation

enum RoverType: CaseIterable, Filterable {
    case all, curiosity, opportunity, spirit

    var asString: String {
        switch self {
        case .all:
            "All"
        case .curiosity:
            "Curiosity"
        case .opportunity:
            "Opportunity"
        case .spirit:
            "Spirit"
        }
    }

    var abbreviated: String {
        return asString
    }
}

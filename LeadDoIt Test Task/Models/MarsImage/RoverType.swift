import Foundation

enum RoverType: CaseIterable, Filterable {
    case all, curiosity, opportunity, spirit

    init(_ name: String) {
        for curCase in Self.allCases {
            if name == curCase.abbreviated {
                self = curCase
                return
            }
        }

        self = .all
    }

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

    var asParameter: String {
        switch self {
        case .all:
            "all"
        case .curiosity:
            "curiosity"
        case .opportunity:
            "opportunity"
        case .spirit:
            "spirit"
        }
    }
}

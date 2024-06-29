import Foundation

enum CameraType: CaseIterable, Filterable {
    case all, fhaz, rhaz, mast, chemcam, mahli, mardi, navcam, pancam, minites

    var asString: String {
        switch self {
        case .all:
            "All"
        case .fhaz:
            "Front Hazard Avoidance Camera"
        case .rhaz:
            "Rear Hazard Avoidance Camera"
        case .mast:
            "Mast Camera"
        case .chemcam:
            "Chemistry and Camera Complex"
        case .mahli:
            "Mars Hand Lens Imager"
        case .mardi:
            "Mars Descent Imager"
        case .navcam:
            "Navigation Camera"
        case .pancam:
            "Panoramic Camera"
        case .minites:
            "Miniature Thermal Emission Spectrometer (Mini-TES)"
        }
    }

    var abbreviated: String {
        switch self {
        case .all:
            "All"
        case .fhaz:
            "FHAZ"
        case .rhaz:
            "RHAZ"
        case .mast:
            "MAST"
        case .chemcam:
            "CHEMCAM"
        case .mahli:
            "MAHLI"
        case .mardi:
            "MARDI"
        case .navcam:
            "NAVCAM"
        case .pancam:
            "PANCAM"
        case .minites:
            "MINITES"
        }
    }
}

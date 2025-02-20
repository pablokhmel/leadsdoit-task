import Foundation

class FilterManager: IFilterManager, ObservableObject {
    func getAvailableRovers(for camera: CameraType) -> [RoverType] {
        return switch camera {
        case .fhaz, .rhaz, .all, .navcam:
            RoverType.allCases

        case .mast, .chemcam, .mahli, .mardi:
            [.all, .curiosity]

        case .pancam, .minites:
            [.all, .opportunity, .spirit]
        }
    }

    func getAvailableCameras(for rover: RoverType) -> [CameraType] {
        return switch rover {
        case .curiosity:
            [.all, .fhaz, .rhaz, .mast, .chemcam, .mahli, .mardi, .navcam]

        case .opportunity, .spirit:
            [.all, .fhaz, .rhaz, .navcam, .pancam, .minites]

        case .all:
            [.all, .fhaz, .rhaz, .mast, .chemcam, .mahli, .mardi, .navcam, .pancam, .minites]
        }
    }
}

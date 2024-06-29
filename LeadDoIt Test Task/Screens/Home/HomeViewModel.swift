import Foundation

class HomeViewModel: ObservableObject {
    @Published var currentRover: RoverType = .all
    @Published var currentCamera: CameraType = .all
    @Published var currentDate: Date = Date()

    private var filterManager: IFilterManager?

    func setup(with filterManager: IFilterManager) {
        self.filterManager = filterManager
    }

    func getFilters<T : Filterable>() -> [T] {
        if T.self == CameraType.self {
            return (filterManager?.getAvailableCameras(for: currentRover) as? [T]) ?? []
        }

        if T.self == RoverType.self {
            return (filterManager?.getAvailableRovers(for: currentCamera) as? [T]) ?? []
        }

        return []
    }
}

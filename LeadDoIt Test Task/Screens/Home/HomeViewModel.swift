import Foundation

class HomeViewModel: ObservableObject {
    @Published var filterOptions: FilterOptions = .defaultOptions

    private var filterManager: IFilterManager?

    func setup(with filterManager: IFilterManager) {
        self.filterManager = filterManager
    }

    func getFilters<T : Filterable>() -> [T] {
        if T.self == CameraType.self {
            return (filterManager?.getAvailableCameras(for: filterOptions.rover) as? [T]) ?? []
        }

        if T.self == RoverType.self {
            return (filterManager?.getAvailableRovers(for: filterOptions.camera) as? [T]) ?? []
        }

        return []
    }
}

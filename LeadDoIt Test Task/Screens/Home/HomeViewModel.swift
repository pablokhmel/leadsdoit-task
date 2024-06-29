import Foundation

class HomeViewModel: ObservableObject {
    @Published var filterOptions: FilterOptions = .defaultOptions
    @Published var images: [MarsImageModel] = []

    private var currentPage = 1
    private var filterManager: IFilterManager?
    private var imagesFetcher: FetchMarsImages?

    @Published var isFetchingImages = false

    func setup(with filterManager: IFilterManager) {
        self.filterManager = filterManager
    }

    func setup(for fetchMarsImages: FetchMarsImages) {
        self.imagesFetcher = fetchMarsImages
        fetchImages()
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

    func filtresChanged() {
        currentPage = 1
        images = []
        fetchImages()
    }

    func fetchImages() {
        Task { [weak self] in
            guard let self = self, !self.isFetchingImages else { return }

            self.isFetchingImages = true
            let images = try await imagesFetcher?.fetchImages(self.filterOptions, page: &currentPage)

            await MainActor.run {
                self.images += images ?? []
                self.isFetchingImages = false
            }
        }
    }
}

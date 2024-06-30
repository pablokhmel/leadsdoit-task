import Foundation

class HomeViewModel: ObservableObject {
    @Published var filterOptions: FilterOptions = .defaultOptions
    @Published var images: [MarsImageModel] = []

    private var currentPage = 1
    private var filterManager: IFilterManager?
    private var imagesFetcher: FetchMarsImages?
    private var fetchedAllImages = false

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
        fetchedAllImages = false
        images = []
        fetchImages()
    }

    func fetchImages() {
        guard !isFetchingImages, !fetchedAllImages else { return }
        isFetchingImages = true

        Task { [weak self] in
            guard let self = self else { return }

            let images = try await imagesFetcher?.fetchImages(self.filterOptions, page: &currentPage)
            self.fetchedAllImages = (images ?? []).count < 25

            await MainActor.run {
                self.images += images ?? []
                self.isFetchingImages = false
            }
        }
    }
}

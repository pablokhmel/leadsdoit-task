import Foundation

class HomeViewModel: ObservableObject {
    @Published var filterOptions: FilterOptions = .defaultOptions
    @Published var images: [MarsImageModel] = []

    private var currentPage = 1

    private var filterManager: IFilterManager?
    private var imagesFetcher: IFetchMarsImages?
    private var realmAddable: ICoreDataAddable?

    private var fetchedAllImages = false

    @Published var isFetchingImages = false

    func setup(filterManager: IFilterManager) {
        self.filterManager = filterManager
    }

    func setup(fetchMarsImages: IFetchMarsImages) {
        self.imagesFetcher = fetchMarsImages
        fetchImages()
    }

    func setup(realmAddable: ICoreDataAddable) {
        self.realmAddable = realmAddable
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

    func saveCurrentFilter() {
        print("Save Filters")
    }
}

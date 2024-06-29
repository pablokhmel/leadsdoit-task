import Foundation

protocol FetchMarsImages {
    func fetchImages(_ filters: FilterOptions, page: inout Int, recursionDepth: Int) async throws -> [MarsImageModel]
}

extension FetchMarsImages {
    func fetchImages(_ filters: FilterOptions, page: inout Int) async throws -> [MarsImageModel] {
        return try await fetchImages(filters, page: &page, recursionDepth: 2)
    }
}

import SwiftUI

class NetworkManager: ObservableObject, FetchMarsImages {
    private let apiKey = "aBr3FZdRsaWUefigmcvrHaRWAY2oBjWDLuB8e9bC"
    private let urlHeadString = "https://api.nasa.gov/mars-photos/api/v1/rovers"

    func fetchImages(_ filters: FilterOptions, page: inout Int, recursionDepth: Int) async throws -> [MarsImageModel] {
        let parameters = createParameters(filters, page: page)

        guard
            let url = try createUrl(rover: filters.rover, page: page, parameters: parameters)
        else { return [] }

        let (data, response) = try await URLSession.shared.data(from: url)

        print(url.absoluteString)

        if (response as? HTTPURLResponse)?.statusCode == 200 {
            let decoder = JSONDecoder()
            let photosDataModels = try decoder.decode(MarsPhotosResponse.self, from: data)

            let photosModels = photosDataModels.photos.map { MarsImageModel($0) }
            print(photosModels.count)

            if photosModels.count < 25 && recursionDepth != 0 {
                page = page + 1
                return photosModels + (try await fetchImages(filters, page: &page, recursionDepth: recursionDepth - 1))
            } else {
                return photosModels
            }
        }

        return []
    }

    private func createUrl(rover: RoverType, page: Int, parameters: [URLQueryItem]) throws -> URL? {
        let rovers: [RoverType] = [.curiosity, .opportunity, .spirit]

        let rover = if rover == .all {
            rovers[(page - 1) % rovers.count]
        } else {
            rover
        }

        guard
            let url = URL(string: urlHeadString + "/" + rover.asParameter + "/photos"),
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else { return nil }

        urlComponents.queryItems = parameters

        guard
            let urlWithQueries = urlComponents.url
        else { return nil }

        return urlWithQueries
    }

    private func createParameters(_ filters: FilterOptions, page: Int) -> [URLQueryItem] {
        var parameters: [URLQueryItem] = []

        parameters.append(URLQueryItem(name: "api_key", value: apiKey))
        parameters.append(URLQueryItem(name: "page", value: String(page)))

        if filters.camera != .all {
            parameters.append(URLQueryItem(name: "camera", value: filters.camera.asParameter))
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-M-dd"
        let dateString = dateFormatter.string(from: filters.date)

        parameters.append(URLQueryItem(name: "earth_date", value: dateString))

        return parameters
    }
}

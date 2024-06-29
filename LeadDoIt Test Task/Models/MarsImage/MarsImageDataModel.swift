import Foundation

struct MarsPhotosResponse: Decodable {
    let photos: [MarsImageDataModel]
}

struct MarsImageDataModel: Decodable {
    let id: Int
    let sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case id
        case sol
        case camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }

    struct Camera: Decodable {
        let name: String
        let fullName: String

        enum CodingKeys: String, CodingKey {
            case name
            case fullName = "full_name"
        }
    }

    struct Rover: Decodable {
        let id: Int
        let name: String
        let landingDate: String
        let launchDate: String
        let status: String
        let maxSol: Int
        let maxDate: String
        let totalPhotos: Int
        let cameras: [Camera]

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case landingDate = "landing_date"
            case launchDate = "launch_date"
            case status
            case maxSol = "max_sol"
            case maxDate = "max_date"
            case totalPhotos = "total_photos"
            case cameras
        }
    }
}

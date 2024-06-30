import SwiftUI

protocol Filterable: Hashable {
    var asString: String { get }
    var abbreviated: String { get }
    var asParameter: String { get }
}

struct MarsImageModel: Identifiable, Equatable {
    let rover: RoverType
    let camera: CameraType
    let date: Date
    let imageUrl: String
    let id: Int

    var dateAsString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, y"
        return formatter.string(from: date)
    }

    init(_ dataModel: MarsImageDataModel) {
        id = dataModel.id
        
        rover = RoverType(dataModel.rover.name)
        camera = CameraType(dataModel.camera.name)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"

        date = dateFormatter.date(from: dataModel.earthDate) ?? Date()
        imageUrl = dataModel.imgSrc
    }
}

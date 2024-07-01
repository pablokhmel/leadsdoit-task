import Foundation

struct FilterOptions: Equatable, Hashable {
    var camera: CameraType
    var rover: RoverType
    var date: Date

    var dateAsString: String {
        let df = DateFormatter()
        df.dateFormat = "dd MMMM, y"
        return df.string(from: date)
    }

    static var defaultOptions: FilterOptions {
        FilterOptions(camera: .all, rover: .all, date: Date())
    }
}

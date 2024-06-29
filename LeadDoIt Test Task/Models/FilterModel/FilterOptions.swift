import Foundation

struct FilterOptions {
    var camera: CameraType
    var rover: RoverType
    var date: Date

    static var defaultOptions: FilterOptions {
        FilterOptions(camera: .all, rover: .all, date: Date())
    }
}

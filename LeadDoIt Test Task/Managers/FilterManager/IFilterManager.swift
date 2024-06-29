import Foundation

protocol IFilterManager {
    func getAvailableRovers(for camera: CameraType) -> [RoverType]
    func getAvailableCameras(for rover: RoverType) -> [CameraType]
}

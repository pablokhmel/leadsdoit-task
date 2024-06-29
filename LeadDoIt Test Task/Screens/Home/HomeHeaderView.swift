import SwiftUI

struct HomeHeaderView: View {
    @Binding var currentDate: Date
    @Binding var currentRover: RoverType
    @Binding var currentCamera: CameraType

    var roverAction: () -> Void = {}
    var cameraAction: () -> Void = {}

    private var plusButtonSide: CGFloat = 38
    private var showCameraFilter = false

    init(
        currentDate: Binding<Date>, 
        currentRover: Binding<RoverType>,
        currentCamera: Binding<CameraType>
    ) {
        self._currentDate = currentDate
        self._currentRover = currentRover
        self._currentCamera = currentCamera
    }

    var body: some View {
        ZStack {
            Color.accentOne
                .ignoresSafeArea()

            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("MARS.CAMERA")
                            .font(Font.CustomFonts.largeTitle)

                        Text(getCurrentDateAsString())
                            .font(Font.CustomFonts.bodyTwo)
                    }

                    Spacer()

                    Image.calendar
                }

                HStack(spacing: 23) {
                    HStack(spacing: 12) {
                        FilterButton(image: Image.rover, action: roverAction, text: currentRover.abbreviated)
                        FilterButton(image: Image.camera, action: cameraAction, text: currentCamera.abbreviated)
                    }

                    Button {

                    } label: {
                        Image.addCircle
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.backgroundOne)
                                    .frame(width: plusButtonSide, height: plusButtonSide)
                            }
                    }
                }
            }
            .padding([.leading, .trailing], 20)
        }
        .foregroundStyle(Color.layerOne)
    
    }

    private func getCurrentDateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.dateFormat = "dd MMMM, y"
        return formatter.string(from: Date())
    }

    func roverAction(_ action: @escaping () -> Void) -> HomeHeaderView {
        var copy = self
        copy.roverAction = action
        return copy
    }

    func cameraAction(_ action: @escaping () -> Void) -> HomeHeaderView {
        var copy = self
        copy.cameraAction = action
        return copy
    }
}

#Preview {
    HomeHeaderView(
        currentDate: .constant(Date()),
        currentRover: .constant(.all),
        currentCamera: .constant(.all)
    )
}

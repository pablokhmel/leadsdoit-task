import SwiftUI

struct HomeHeaderView: View {
    @Binding var filterOptions: FilterOptions

    var roverAction: () -> Void = {}
    var cameraAction: () -> Void = {}
    var dateAction: () -> Void = {}

    private var plusButtonSide: CGFloat = 38
    private var showCameraFilter = false

    init(currentFilter: Binding<FilterOptions>) {
        _filterOptions = currentFilter
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

                    Button {
                        dateAction()
                    } label: {
                        Image.calendar
                    }
                }

                HStack(spacing: 23) {
                    HStack(spacing: 12) {
                        FilterButton(image: Image.rover, action: roverAction, text: filterOptions.rover.abbreviated)
                        FilterButton(image: Image.camera, action: cameraAction, text: filterOptions.camera.abbreviated)
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
        return formatter.string(from: filterOptions.date)
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

    func dateAction(_ action: @escaping () -> Void) -> HomeHeaderView {
        var copy = self
        copy.dateAction = action
        return copy
    }
}

#Preview {
    HomeHeaderView(currentFilter: .constant(.defaultOptions))
}

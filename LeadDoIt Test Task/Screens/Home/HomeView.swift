import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var filterManager: FilterManager

    @State var filterType: FilterType = .none

    var body: some View {
        ZStack {
            VStack {
                HomeHeaderView(currentFilter: $viewModel.filterOptions)
                .roverAction {
                    guard filterType == .none else { return }
                    withAnimation {
                        filterType = .rover
                    }
                }
                .cameraAction {
                    guard filterType == .none else { return }
                    withAnimation {
                        filterType = .camera
                    }
                }
                .frame(height: 148)

                Spacer()
            }
            .onAppear {
                viewModel.setup(with: filterManager)
            }

            VStack {
                Spacer()

                if filterType != .none {
                    createFilterWheelView()
                        .transition(.move(edge: .bottom))
                }
            }
            .ignoresSafeArea()
        }
    }

    @ViewBuilder
    private func createFilterWheelView() -> some View {
        switch filterType {
        case .camera:
            FilterWheelView(text: "Camera", $viewModel.filterOptions.camera, filters: viewModel.getFilters())
                .onHide {
                    withAnimation {
                        filterType = .none
                    }
                }

        case .rover:
            FilterWheelView(text: "Rover", $viewModel.filterOptions.rover, filters: viewModel.getFilters())
                .onHide {
                    withAnimation {
                        filterType = .none
                    }
                }

        case .none:
            EmptyView()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(FilterManager())
}

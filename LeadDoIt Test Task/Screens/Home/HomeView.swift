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
                        withAnimation {
                            filterType = .rover
                        }
                    }
                    .cameraAction {
                        withAnimation {
                            filterType = .camera
                        }
                    }
                    .dateAction {
                        withAnimation {
                            filterType = .date
                        }
                    }
                    .disabled(filterType != .none)
                    .frame(height: 148)

                Spacer()
            }
            .onAppear {
                viewModel.setup(with: filterManager)
            }
            .disabled(filterType != .none)

            VStack {
                Spacer()

                if filterType == .camera || filterType == .rover {
                    createFilterWheelView()
                        .transition(.move(edge: .bottom))
                }
            }
            .ignoresSafeArea()

            if filterType == .date {
                Color.black.opacity(0.4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()

                ZStack {
                    DateFilterWheelView(date: $viewModel.filterOptions.date)
                        .hide {
                            filterType = .none
                        }
                        .padding(20)
                }
            }
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

        case .none, .date:
            EmptyView()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(FilterManager())
}

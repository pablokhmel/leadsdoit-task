import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()

    @EnvironmentObject private var filterManager: FilterManager
    @EnvironmentObject private var networkManager: NetworkManager

    @State var filterType: FilterType = .none

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
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
                    .customOnChange(of: viewModel.filterOptions) {
                        viewModel.filtresChanged()
                    }

                VStack {
                    if viewModel.isFetchingImages {
                        ProgressView()
                    } else if viewModel.images.count == 0 {
                        VStack(spacing: 20) {
                            Image.empty
                            Text("List is empty. Change your filters.")
                                .font(.CustomFonts.body)
                                .foregroundStyle(Color.layerTwo)
                        }
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(viewModel.images) { image in
                                    MarsPhotoRowView(model: image)
                                        .padding(10)
                                        .padding(.leading, 6)
                                        .background {
                                            RoundedRectangle(cornerRadius: 30)
                                                .fill(Color.backgroundOne)
                                                .shadow(radius: 16, y: 3)
                                        }
                                }
                            }
                            .ignoresSafeArea()
                            .padding(20)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .onAppear {
                viewModel.setup(with: filterManager)
                viewModel.setup(for: networkManager)
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
        .environmentObject(NetworkManager())
}

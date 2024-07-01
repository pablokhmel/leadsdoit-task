import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()

    @EnvironmentObject private var filterManager: FilterManager
    @EnvironmentObject private var networkManager: NetworkManager
    @EnvironmentObject private var coreDataManager: CoreDataManager

    @State private var filterType: FilterType = .none
    @State private var isDetailViewActive = false
    @State private var selectedImageUrl: String?
    @State private var showAlert = false

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
                    .addFilterAction {
                        showAlert = true
                    }
                    .disabled(filterType != .none)
                    .frame(height: 148)
                    .customOnChange(of: viewModel.filterOptions) {
                        viewModel.filtresChanged()
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Save Filters"),
                            message: Text("The current filters and the date you have chosen can be saved to the filter history."),
                            primaryButton: .default(Text("Save")) {
                                viewModel.saveCurrentFilter()
                            },
                            secondaryButton: .cancel()
                        )
                    }


                VStack {
                    if viewModel.isFetchingImages && viewModel.images.count == 0 {
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
                                        .onTapGesture {
                                            selectedImageUrl = image.imageUrl
                                            isDetailViewActive = true
                                        }
                                        .onAppear {
                                            if image == viewModel.images.last {
                                                viewModel.fetchImages()
                                            }
                                        }
                                }

                                if viewModel.isFetchingImages {
                                    ProgressView()
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
                viewModel.setup(filterManager: filterManager)
                viewModel.setup(fetchMarsImages: networkManager)
                viewModel.setup(realmAddable: coreDataManager)
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

            VStack {
                Spacer()

                HStack {
                    Spacer()

                    NavigationLink {

                    } label: {
                        
                    }
                }
            }

            VStack {
                Spacer()

                HStack {
                    Spacer()

                    NavigationLink {
                        FilterHistory(coreDataManager, currentFilter: $viewModel.filterOptions)
                            .navigationBarBackButtonHidden()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.accentOne)
                                .frame(width: 70)

                            Image.history
                        }

                    }
                }
                .padding(20)
            }

            if filterType == .date {
                Color.black.opacity(0.4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()

                DateFilterWheelView(date: $viewModel.filterOptions.date)
                    .hide {
                        filterType = .none
                    }
                .padding(20)
            }
        }
        .background(
            NavigationLink(
                destination:
                    DetailPhotoView(image: selectedImageUrl ?? "")
                    .navigationBarBackButtonHidden(),
                isActive: $isDetailViewActive
            ) {
                EmptyView()
            }
        )
        .background(
            Color.backgroundOne
        )
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
    NavigationView {
        HomeView()
            .environmentObject(FilterManager())
            .environmentObject(NetworkManager())
            .environmentObject(CoreDataManager())
    }
}

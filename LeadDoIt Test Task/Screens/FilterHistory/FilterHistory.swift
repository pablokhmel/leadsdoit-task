//
//  FilterHistory.swift
//  LeadDoIt Test Task
//
//  Created by MacBook on 30.06.2024.
//

import SwiftUI

struct FilterHistory: View {
    @Binding var currentFilter: FilterOptions
    @Environment(\.presentationMode) var presentationMode

    @State private var filters: [FilterOptions]
    @State private var showActionSheet = false

    private var manager: ICoreDataDeletable

    init(_ manager: ICoreDataDeletable, currentFilter: Binding<FilterOptions>) {
        filters = manager.load()
        self.manager = manager
        _currentFilter = currentFilter
    }

    var body: some View {
        VStack {
            VStack {
                ZStack {
                    Color.accentOne
                        .ignoresSafeArea()

                    Text("History")
                        .font(.CustomFonts.largeTitle)

                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image.backButton
                        }

                        Spacer()
                    }
                    .padding(26)
                }
                .frame(height: 78)
            }

            if filters.isEmpty {
                VStack(spacing: 20) {
                    Image.empty
                    Text("Browsing history is empty.")
                        .font(.CustomFonts.body)
                        .foregroundStyle(Color.layerTwo)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(filters, id: \.self) { filter in 
                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Rectangle()
                                        .fill(Color.accentOne)
                                        .frame(height: 1)

                                    Text("Filters")
                                        .font(.CustomFonts.titleTwo)
                                        .foregroundStyle(Color.accentOne)
                                }

                                TextWithTitle(title: "Rover: ", text: filter.rover.asString)
                                TextWithTitle(title: "Camera: ", text: filter.camera.asString)
                                TextWithTitle(title: "Date", text: filter.dateAsString)
                            }
                            .padding(.top, 10)
                            .padding([.horizontal, .bottom], 15)
                            .background {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.backgroundOne)
                                    .shadow(color: Color.black.opacity(0.08), radius: 16, y: 3)
                            }
                            .onTapGesture {
                                showActionSheet = true
                            }
                            .actionSheet(isPresented: $showActionSheet) {
                                        ActionSheet(
                                            title: Text("Menu filter"),
                                            buttons: [
                                                .default(Text("Use")) {
                                                    currentFilter = filter
                                                },
                                                .destructive(Text("Delete")) {
                                                    manager.delete(filterOptions: filter)
                                                    filters = manager.load()
                                                },
                                                .cancel()
                                            ]
                                        )
                                    }
                        }
                    }
                    .padding(20)
                }
            }
        }
    }
}

#Preview {
    FilterHistory(CoreDataManager(), currentFilter: .constant(FilterOptions.defaultOptions))
}

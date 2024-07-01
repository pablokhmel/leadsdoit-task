//
//  FilterWheelView.swift
//  LeadDoIt Test Task
//
//  Created by MacBook on 28.06.2024.
//

import SwiftUI

struct FilterWheelView<T : Filterable> : View {
    @Binding private var chosenFilter: T
    @State private var filterToShow: T
    private let text: String
    private let filters: [T]
    private var onHide: () -> Void = {}

    init(text: String, _ currentFilter: Binding<T>, filters: [T]) {
        _chosenFilter = currentFilter
        _filterToShow = State(initialValue: currentFilter.wrappedValue)
        self.text = text
        self.filters = filters
    }

    var body: some View {
        VStack {
            HStack {
                Button {
                    onHide()
                } label: {
                    Image.close
                }

                Spacer()

                Text(text)
                    .font(.CustomFonts.titleTwo)

                Spacer()

                Button {
                    chosenFilter = filterToShow
                    onHide()
                } label: {
                    Image.tick
                }
            }


            Picker("Chosen filter", selection: $filterToShow) {
                ForEach(filters, id: \.self) { filter in
                    Text(filter.asString)
                        .font(filter == filterToShow ? Font.CustomFonts.titleTwo : Font.CustomFonts.title)
                }

            }
            .pickerStyle(.wheel)
            .frame(height: 250)
            .preferredColorScheme(.light)

        }
        .padding(20)
        .background {
            UnevenRoundedRectangle(topLeadingRadius: 50, topTrailingRadius: 50)
                .fill(Color.backgroundOne)
                .shadow(color: Color.black.opacity(0.1), radius: 14, y: -4)
        }
        .foregroundStyle(Color.layerOne)
    }

    public func onHide(_ action: @escaping () -> Void) -> FilterWheelView {
        var copy = self
        copy.onHide = action
        return copy
    }
}

#Preview {
    FilterWheelView(text: "Camera", .constant(RoverType.all), filters: [RoverType.all, RoverType.curiosity])
}

import SwiftUI

struct DateFilterWheelView: View {
    @Binding var date: Date
    @State var pickedDate: Date
    private var hideAction: () -> Void = {}

    init(date: Binding<Date>) {
        self._date = date
        _pickedDate = State(initialValue: date.wrappedValue)
    }

    var body: some View {
        VStack {
            HStack {
                Button {
                    hideAction()
                } label: {
                    Image.close
                }

                Text("Date")
                    .font(.CustomFonts.titleTwo)
                    .frame(maxWidth: .infinity)

                Button {
                    date = pickedDate
                    hideAction()
                } label: {
                    Image.tick
                }
            }

            DatePicker("", selection: $pickedDate, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .frame(height: 250)
                .frame(maxWidth: .infinity)
                .preferredColorScheme(.light)
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 50)
                .fill (Color.backgroundOne)
                .shadow(radius: 16, y: 3)
        }
        .foregroundStyle(Color.layerOne)
    }

    public func hide(_ action: @escaping () -> Void) -> DateFilterWheelView {
        var copy = self
        copy.hideAction = action
        return copy
    }
}

#Preview {
    DateFilterWheelView(date: .constant(Date()))
}

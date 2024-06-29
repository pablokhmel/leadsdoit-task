import SwiftUI

struct FilterButton: View {
    let image: Image
    let action: () -> Void
    let text: String

    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 6) {
                image

                Text(text)
                    .font(Font.CustomFonts.bodyTwo)

                Spacer()
            }
            .padding(7)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.backgroundOne)
            }
        }
    }
}

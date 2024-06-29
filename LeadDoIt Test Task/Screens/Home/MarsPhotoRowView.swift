import SwiftUI

struct MarsPhotoRowView: View {
    let model: MarsImageModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                PhotoRowInfoText(title: "Rover", text: model.rover.asString)
                PhotoRowInfoText(title: "Camera", text: model.camera.asString)
                PhotoRowInfoText(title: "Date", text: model.dateAsString)
            }

            Spacer()

            LazyLoadImage(imageUrl: model.imageUrl)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .frame(width: 130, height: 130)
        }
    }
}

struct PhotoRowInfoText: View {
    let title: String
    let text: String

    var body: some View {
        Text("\(title):  ")
            .font(.CustomFonts.body)
            .foregroundColor(Color.layerTwo) +
        Text(text)
            .font(.CustomFonts.bodyTwo)
    }
}

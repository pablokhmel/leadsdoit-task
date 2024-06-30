import SwiftUI

struct DetailPhotoView: View {
    @Environment(\.presentationMode) var presentationMode
    let image: String

    var body: some View {
        ZStack {
            VStack {
                Color.black
            }
            .ignoresSafeArea()


            LazyLoadImage(imageUrl: image)
                .aspectRatio(contentMode: .fit)

            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image.closeWhite
                    }

                    Spacer()
                }

                Spacer()
            }
            .padding(20)
        }
    }
}

#Preview {
    DetailPhotoView(image: "https://picsum.photos/600")
}

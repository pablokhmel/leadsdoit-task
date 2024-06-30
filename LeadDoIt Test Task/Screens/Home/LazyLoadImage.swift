import SwiftUI

struct LazyLoadImage: View {
    @State private var image: UIImage? = nil
    let imageUrl: String

    @State var hasError = false

    var body: some View {
        GeometryReader { geometry in
            if self.image == nil {
                ZStack {
                    Color.gray
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .onAppear {
                            self.loadImage()
                        }

                    if !hasError {
                        ProgressView()
                    }
                }
            } else {
                Image(uiImage: self.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .onAppear {
                        self.loadImage()
                    }
            }
        }
    }

    private func loadImage() {
        Task {
            do {
                guard
                    let url = URL(string: imageUrl)
                else { return }

                let (data, _) = try await URLSession.shared.data(from: url)
                await MainActor.run {
                    if let uiImage = UIImage(data: data) {
                        image = uiImage
                    } else {
                        hasError = true
                    }
                }
            } catch {
                hasError = true
            }

        }
    }
}

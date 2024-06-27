import SwiftUI

struct PreloaderView: View {
    @State private var isActive = false

    private let squareSide: CGFloat = 123
    private let squareCornerRadius: CGFloat = 30
    private let animationJsonFileName = "Loader_Test"

    var body: some View {
        VStack {
            if isActive {
                HomeView()
            } else {
                ZStack {
                    VStack {
                        Color.backgroundOne
                    }
                    .ignoresSafeArea()

                    RoundedRectangle(cornerRadius: squareCornerRadius)
                        .fill(Color.accentOne)
                        .frame(width: squareSide, height: squareSide)
                        .overlay {
                            RoundedRectangle(cornerRadius: squareCornerRadius)
                                .stroke(Color.layerOne, lineWidth: 1)
                                .frame(width: squareSide, height: squareSide)

                        }

                    VStack {
                        Spacer()

                        LottieView(animationName: animationJsonFileName)
                            .frame(width: 250, height: 34)

                        Spacer()
                            .frame(height: 114)
                    }
                }
                .onAppear {
                    // here should be something to get on launch...
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PreloaderView()
    }
}

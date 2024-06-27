import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HomeHeaderView()
                .frame(height: 148)

            List(selection: <#T##Binding<SelectionValue>#>, content: <#T##() -> Content#>)

            Spacer()
        }
    }
}

#Preview {
    HomeView()
}

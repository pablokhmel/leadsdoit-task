import SwiftUI

@main
struct LeadDoIt_Test_TaskApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PreloaderView()
                    .environmentObject(FilterManager())
                    .environmentObject(NetworkManager())
                    .environmentObject(CoreDataManager())
            }
        }
    }
}

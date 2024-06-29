import SwiftUI

@main
struct LeadDoIt_Test_TaskApp: App {
    var body: some Scene {
        WindowGroup {
            PreloaderView()
                .environmentObject(FilterManager())
                .environmentObject(NetworkManager())
        }
    }
}

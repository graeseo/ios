import SwiftUI

@main
struct GraeseoApp: App {
    var body: some Scene {
        WindowGroup {
            MainFeedView(feedUrl: AppConfig.feedUrl)
        }
    }
}

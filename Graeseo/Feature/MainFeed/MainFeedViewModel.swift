import Foundation

@Observable
final class MainFeedViewModel {
    let feedUrl: String

    init(feedUrl: String) {
        self.feedUrl = feedUrl
    }
}

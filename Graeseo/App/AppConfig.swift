import Foundation

enum AppConfig {
    static let feedUrl: String = {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "FeedURL") as? String, !url.isEmpty else {
            return "http://localhost:5173"
        }
        return url
    }()
}

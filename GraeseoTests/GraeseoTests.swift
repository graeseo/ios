import XCTest

final class GraeseoTests: XCTestCase {
    func testFeedUrlFromAppConfig() {
        XCTAssertFalse(AppConfig.feedUrl.isEmpty)
    }
}

import XCTest
@testable import Graeseo

final class GraeseoTests: XCTestCase {
    func testFeedUrlFromAppConfig() {
        XCTAssertFalse(AppConfig.feedUrl.isEmpty)
    }
}

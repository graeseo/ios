import XCTest
@testable import Domain

// MARK: - Fake Repository

private struct FakeStockEventRepository: StockEventRepository {
    let events: [StockEvent]

    func getAll() async throws -> [StockEvent] {
        return events
    }

    func getByFilter(_ filter: EventFilter) async throws -> [StockEvent] {
        guard let key = filter else { return events }
        return events.filter { $0.stock == key }
    }

    func getById(_ id: String) async throws -> StockEvent? {
        return events.first { $0.id == id }
    }
}

// MARK: - Tests

final class GetStockEventsUseCaseTests: XCTestCase {

    private func makeEvent(id: String, stock: StockKey?) -> StockEvent {
        StockEvent(
            id: id,
            title: "Test Event \(id)",
            date: "2026-06-01",
            daysLeft: 7,
            stock: stock,
            concept: "Test Concept",
            why: "Test Why",
            importance: .medium
        )
    }

    private func makeSampleEvents() -> [StockEvent] {
        [
            makeEvent(id: "1", stock: .tsla),
            makeEvent(id: "2", stock: .pltr),
            makeEvent(id: "3", stock: nil),
        ]
    }

    func test_all필터는_전체_이벤트를_반환한다() async throws {
        let repo = FakeStockEventRepository(events: makeSampleEvents())
        let useCase = GetStockEventsUseCase(repository: repo)

        let result = try await useCase.execute(filter: nil)

        XCTAssertEqual(result.count, 3)
    }

    func test_tsla필터는_tsla이벤트만_반환한다() async throws {
        let repo = FakeStockEventRepository(events: makeSampleEvents())
        let useCase = GetStockEventsUseCase(repository: repo)

        let result = try await useCase.execute(filter: .tsla)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.stock, .tsla)
    }

    func test_pltr필터는_pltr이벤트만_반환한다() async throws {
        let repo = FakeStockEventRepository(events: makeSampleEvents())
        let useCase = GetStockEventsUseCase(repository: repo)

        let result = try await useCase.execute(filter: .pltr)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.stock, .pltr)
    }

    func test_빈_저장소는_빈_배열을_반환한다() async throws {
        let repo = FakeStockEventRepository(events: [])
        let useCase = GetStockEventsUseCase(repository: repo)

        let result = try await useCase.execute(filter: nil)

        XCTAssertTrue(result.isEmpty)
    }

    func test_필터에_매칭되는_이벤트가_없으면_빈_배열을_반환한다() async throws {
        let events = [makeEvent(id: "1", stock: .tsla)]
        let repo = FakeStockEventRepository(events: events)
        let useCase = GetStockEventsUseCase(repository: repo)

        let result = try await useCase.execute(filter: .pltr)

        XCTAssertTrue(result.isEmpty)
    }
}

import XCTest
@testable import Domain

// MARK: - Fake Repository

private struct FakeScenarioRepository: ScenarioRepository {
    let scenarios: [String: Scenario]

    func getByEventId(_ eventId: String, stock: StockKey) async throws -> Scenario? {
        return scenarios[eventId]
    }
}

// MARK: - Tests

final class GetScenariosForEventUseCaseTests: XCTestCase {

    private func makeSampleScenario(eventId: String, stock: StockKey) -> Scenario {
        Scenario(
            eventId: eventId,
            stock: stock,
            cards: [
                ScenarioCard(
                    direction: .up,
                    title: "상승 시나리오",
                    oneLine: "실적 서프라이즈 시 강한 반등",
                    why: "어닝 서프라이즈가 발생하면 매수세 유입 가능",
                    signals: [ScenarioSignal(label: "매출 YoY +20% 초과")],
                    probability: 40
                ),
                ScenarioCard(
                    direction: .flat,
                    title: "횡보 시나리오",
                    oneLine: "예상치 부합 시 방향성 부재",
                    why: "기대치가 이미 반영된 상태",
                    signals: [ScenarioSignal(label: "EPS 컨센 ±5% 이내")],
                    probability: 35
                ),
                ScenarioCard(
                    direction: .down,
                    title: "하락 시나리오",
                    oneLine: "가이던스 하향 시 조정 가능",
                    why: "성장 둔화 우려가 매도로 연결",
                    signals: [ScenarioSignal(label: "가이던스 하향")],
                    probability: 25
                ),
            ]
        )
    }

    func test_이벤트와_종목으로_시나리오를_조회할_수_있다() async throws {
        let scenario = makeSampleScenario(eventId: "evt-1", stock: .tsla)
        let repo = FakeScenarioRepository(scenarios: ["evt-1": scenario])
        let useCase = GetScenariosForEventUseCase(repository: repo)

        let result = try await useCase.execute(eventId: "evt-1", stock: .tsla)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.eventId, "evt-1")
        XCTAssertEqual(result?.stock, .tsla)
    }

    func test_시나리오는_up_flat_down_카드_3개를_가진다() async throws {
        let scenario = makeSampleScenario(eventId: "evt-1", stock: .tsla)
        let repo = FakeScenarioRepository(scenarios: ["evt-1": scenario])
        let useCase = GetScenariosForEventUseCase(repository: repo)

        let result = try await useCase.execute(eventId: "evt-1", stock: .tsla)

        XCTAssertEqual(result?.cards.count, 3)
        let directions = result?.cards.map { $0.direction } ?? []
        XCTAssertTrue(directions.contains(.up))
        XCTAssertTrue(directions.contains(.flat))
        XCTAssertTrue(directions.contains(.down))
    }

    func test_카드_확률의_합은_100이다() async throws {
        let scenario = makeSampleScenario(eventId: "evt-1", stock: .tsla)
        let repo = FakeScenarioRepository(scenarios: ["evt-1": scenario])
        let useCase = GetScenariosForEventUseCase(repository: repo)

        let result = try await useCase.execute(eventId: "evt-1", stock: .tsla)

        let totalProbability = result?.cards.reduce(0) { $0 + $1.probability } ?? 0
        XCTAssertEqual(totalProbability, 100)
    }

    func test_존재하지_않는_이벤트ID_조회_시_nil_반환() async throws {
        let repo = FakeScenarioRepository(scenarios: [:])
        let useCase = GetScenariosForEventUseCase(repository: repo)

        let result = try await useCase.execute(eventId: "non-existent", stock: .tsla)

        XCTAssertNil(result)
    }
}

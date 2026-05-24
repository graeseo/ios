public protocol ScenarioRepository {
    func getByEventId(_ eventId: String, stock: StockKey) async throws -> Scenario?
}

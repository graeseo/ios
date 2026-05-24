public protocol StockEventRepository {
    func getAll() async throws -> [StockEvent]
    func getByFilter(_ filter: EventFilter) async throws -> [StockEvent]
    func getById(_ id: String) async throws -> StockEvent?
}

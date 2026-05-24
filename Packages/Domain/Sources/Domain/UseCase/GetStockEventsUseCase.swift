public final class GetStockEventsUseCase {
    private let repository: StockEventRepository
    public init(repository: StockEventRepository) { self.repository = repository }
    public func execute(filter: EventFilter) async throws -> [StockEvent] {
        return try await repository.getByFilter(filter)
    }
}

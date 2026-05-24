public final class GetScenariosForEventUseCase {
    private let repository: ScenarioRepository
    public init(repository: ScenarioRepository) { self.repository = repository }
    public func execute(eventId: String, stock: StockKey) async throws -> Scenario? {
        return try await repository.getByEventId(eventId, stock: stock)
    }
}

public typealias EventFilter = StockKey?  // nil = all
public struct StockEvent {
    public let id: String
    public let title: String
    public let date: String
    public let daysLeft: Int
    public let stock: StockKey?
    public let concept: String
    public let why: String
    public let importance: Importance
    public enum Importance { case high, medium }
    public init(id: String, title: String, date: String, daysLeft: Int,
                stock: StockKey?, concept: String, why: String, importance: Importance) {
        self.id = id; self.title = title; self.date = date; self.daysLeft = daysLeft
        self.stock = stock; self.concept = concept; self.why = why; self.importance = importance
    }
}

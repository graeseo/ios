public enum ScenarioDirection { case up, flat, down }
public struct ScenarioSignal {
    public let label: String
    public init(label: String) { self.label = label }
}
public struct ScenarioCard {
    public let direction: ScenarioDirection
    public let title: String
    public let oneLine: String
    public let why: String
    public let signals: [ScenarioSignal]
    public let probability: Int
    public init(direction: ScenarioDirection, title: String, oneLine: String,
                why: String, signals: [ScenarioSignal], probability: Int) {
        self.direction = direction; self.title = title; self.oneLine = oneLine
        self.why = why; self.signals = signals; self.probability = probability
    }
}
public struct Scenario {
    public let eventId: String
    public let stock: StockKey
    public let cards: [ScenarioCard]
    public init(eventId: String, stock: StockKey, cards: [ScenarioCard]) {
        self.eventId = eventId; self.stock = stock; self.cards = cards
    }
}

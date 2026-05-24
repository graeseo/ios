public enum StockKey: String { case tsla, pltr }
public struct Stock {
    public let key: StockKey
    public let ticker: String
    public let name: String
    public let priceUSD: Double
    public let changePercent: Double
    public init(key: StockKey, ticker: String, name: String, priceUSD: Double, changePercent: Double) {
        self.key = key; self.ticker = ticker; self.name = name
        self.priceUSD = priceUSD; self.changePercent = changePercent
    }
}

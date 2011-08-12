module TickerFetcher
  class Stock
    attr_reader :symbol, :name, :last_sale, :market_cap, :ipo_year, :sector, :industry

    def initialize(data)
      @symbol = data[TickerFetcher::Retriever::Symbol]
      @name = data[TickerFetcher::Retriever::Name]
      @last_sale = data[TickerFetcher::Retriever::LastSale]
      @market_cap = data[TickerFetcher::Retriever::MarketCap]
      @ipo_year = data[TickerFetcher::Retriever::IPOYear]
      @sector = data[TickerFetcher::Retriever::Sector]
      @industry = data[TickerFetcher::Retriever::Industry]
    end
  end
end

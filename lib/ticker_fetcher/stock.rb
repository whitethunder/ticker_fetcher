module TickerFetcher
  class Stock
    attr_reader :symbol, :name, :last_sale, :market_cap, :sector, :industry

    def initialize(data)
      @symbol = data['Symbol']
      @name = data['Name']
      @last_sale = data['LastSale']
      @market_cap = data['MarketCap']
      @sector = data['Sector']
      @industry = data['Industry']
    end
  end
end

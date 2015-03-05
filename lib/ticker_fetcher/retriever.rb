require 'csv'
require 'open-uri'
require 'ticker_fetcher/stock'

module TickerFetcher
  class Retriever
    attr_reader :exchanges

    # Passing an exchange name will retrieve only that exchange. Default is to retrieve all.
    def initialize
      @exchanges = {}
    end

    def run(exchange=:all)
      if exchange == :all
        EXCHANGE_URLS.each { |exchange, url| @exchanges[exchange] = parse_exchange(exchange, url) }
      else
        @exchanges[exchange] = parse_exchange(exchange, EXCHANGE_URLS[exchange])
      end
    end

    def parse_exchange(exchange, url)
      data = open(url)
      parse_csv(data)
    end

    def [](exchange)
      exchanges[exchange]
    end

    private

    def parse_csv(data)
      CSV.parse(data, headers: true).inject([]) do |stocks, row|
        stocks << TickerFetcher::Stock.new(row)
      end
    end

    def name(row)
      row['Name']
    end

    def ticker(row)
      ticker = row['Symbol'].strip.gsub('"', '')
      unless(ticker.nil? || ticker.empty?)
        ticker = ticker =~ /\W/ ? ticker.gsub('/', '.').gsub('^', '-') : ticker
      end
    end

    def last_sale(row)
      row['LastSale']
    end

    def market_cap(row)
      row['MarketCap']
    end

    def sector(row)
      row['Sector']
    end

    def industry(row)
      row['Industry']
    end
  end
end

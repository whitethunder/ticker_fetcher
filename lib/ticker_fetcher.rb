require 'rubygems'
require 'open-uri'
require 'csv'

class TickerFetcher
  Symbol = 0
  Name = 1
  LastSale = 2
  MarketCap = 3
  Sector = 5
  Industry = 6
  attr_reader :exchanges

  # Passing 1 or more exchange names will retrieve only those exchanges. Default
  # is to retrieve all.
  def initialize
    @exchanges = {}
    @exchange_urls = {
      'NASD' => 'http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NASDAQ&render=download',
      'AMEX' => 'http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=AMEX&render=download',
      'NYSE' => 'http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NYSE&render=download'
    }
  end

  def retrieve(exchange=:all)
    if exchange == :all
      @exchange_urls.each { |exchange, url| @exchanges[exchange] = parse_exchange(exchange, url) }
    else
      @exchanges[exchange] = parse_exchange(exchange, @exchange_urls[exchange])
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
    tickers = []
    CSV.parse(data) { |row|
      name = row[Name]
      ticker = row[Symbol].strip.gsub('"', '')
      unless(ticker.nil? || ticker.empty? || ticker == 'Symbol')
        ticker = ticker.gsub('/', '.').gsub('^', '-') if ticker =~ /\W/
        tickers << [ticker, name]
      end
    }
    tickers
  end
end

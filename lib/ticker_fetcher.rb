require 'rubygems'
require 'open-uri'
require 'csv'

class TickerFetcher
  Symbol = 0
  Name = 1
  LastSale = 2
  MarketCap = 3
  IPOYear = 4
  Sector = 5
  Industry = 6
  attr_reader :exchanges, :exchange_urls

  # Passing an exchange name will retrieve only that exchange. Default is to retrieve all.
  def initialize
    @exchanges = {}
    @exchange_urls = {
      'AMEX' => 'http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=AMEX&render=download',
      'NASD' => 'http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NASDAQ&render=download',
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
    CSV.parse(data, :headers => true).inject([]) do |tickers, row|
      tickers << [ticker(row), name(row), last_sale(row), market_cap(row), ipo_year(row), sector(row), industry(row)]
    end
  end

  def name(row)
    row[Name]
  end

  def ticker(row)
    ticker = row[Symbol].strip.gsub('"', '')
    unless(ticker.nil? || ticker.empty?)
      ticker = ticker =~ /\W/ ? ticker.gsub('/', '.').gsub('^', '-') : ticker
    end
  end

  def last_sale(row)
    row[LastSale]
  end

  def market_cap(row)
    row[MarketCap]
  end

  def ipo_year(row)
    row[IPOYear]
  end

  def sector(row)
    row[Sector]
  end

  def industry(row)
    row[Industry]
  end
end

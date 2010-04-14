require 'rubygems'
require 'open-uri'
require 'fastercsv'

class TickerFetcher
  attr_accessor :exchanges

  # Passing 1 or more exchange names will retrieve only those exchanges. Default
  # is to retrieve all.
  def initialize
    @exchanges = {}
    @exchange_urls = {
      'NASD' => 'http://www.nasdaq.com/asp/symbols.asp?exchange=Q&start=0',
      'AMEX' => 'http://www.nasdaq.com/asp/symbols.asp?exchange=1&start=0',
      'NYSE' => 'http://www.nasdaq.com/asp/symbols.asp?exchange=N&start=0'
    }
  end

  def retrieve(*exchanges_to_get)
    @exchange_urls.delete_if { |k,v| !exchanges_to_get.flatten.include?(k.upcase) } unless exchanges_to_get.empty?
    @exchange_urls.each { |exchange, url| @exchanges[exchange] = parse_exchange(exchange, url) }
  end

  def parse_exchange(exchange, url)
    data = open(url)
    parse_csv(data)
  end

  private

  def parse_csv(data)
    tickers = []
    FasterCSV.parse(data) { |row|
      name = row[0]
      ticker = row[1].strip.gsub('"', '')
      unless(ticker.nil? || ticker.empty? || ticker == 'Symbol')
        ticker = ticker.gsub('/', '.').gsub('^', '-') if ticker =~ /\W/
        description = row[5].strip
        tickers << [ticker, name, description]
      end
    }
    tickers
  end
end

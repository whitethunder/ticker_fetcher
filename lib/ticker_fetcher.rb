require 'ticker_fetcher/retriever'
require 'ticker_fetcher/stock'

module TickerFetcher
  EXCHANGE_URLS = {
    'AMEX' => 'http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=AMEX&render=download',
    'NASD' => 'http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NASDAQ&render=download',
    'NYSE' => 'http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NYSE&render=download'
  }
end
require 'helper'
require 'ticker_fetcher/retriever'

class TestRetriever < Test::Unit::TestCase
  def setup
    @retriever = TickerFetcher::Retriever.new
    TickerFetcher::EXCHANGE_URLS.each do |exchange, url|
      FakeWeb.register_uri(
        :get,
        url,
        :body => File.open("test/#{exchange.downcase}_test_data.csv").read)
    end
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_one_exchange
    @retriever.run('NYSE')
    assert_not_nil(@retriever.exchanges['NYSE'])
    assert_nil(@retriever.exchanges['NASD'])
    assert_nil(@retriever.exchanges['AMEX'])
  end

  def test_retrieve_with_two_exchanges_returns_a_ticker_fetcher_with_two_exchanges
    @retriever.run('NYSE')
    @retriever.run('NASD')
    assert_not_nil(@retriever.exchanges['NYSE'])
    assert_not_nil(@retriever.exchanges['NASD'])
    assert_nil(@retriever.exchanges['AMEX'])
  end

  def test_retrieve_with_all_exchanges_returns_a_ticker_fetcher_with_all_exchanges
    @retriever.run
    @retriever.exchanges.keys.each do |exchange|
      assert_not_nil(@retriever.exchanges[exchange])
    end
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_correct_tickers
    @retriever.run('NYSE')
    assert_equal('SC', @retriever.exchanges['NYSE'].first.symbol)
    assert_equal('ZGEN', @retriever.exchanges['NYSE'].last.symbol)
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_correct_company_names
    @retriever.run('NYSE')
    assert_equal('StupidCompany, Inc.', @retriever.exchanges['NYSE'].first.name)
    assert_equal('ZymoGenetics, Inc.', @retriever.exchanges['NYSE'].last.name)
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_correct_last_sale_price
    @retriever.run('NYSE')
    assert_equal('2.71', @retriever.exchanges['NYSE'].first.last_sale)
    assert_equal('25', @retriever.exchanges['NYSE'].last.last_sale)
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_correct_market_cap
    @retriever.run('NYSE')
    assert_equal('72858350', @retriever.exchanges['NYSE'].first.market_cap)
    assert_equal('85473000', @retriever.exchanges['NYSE'].last.market_cap)
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_correct_sector
    @retriever.run('NYSE')
    assert_equal('Consumer Services', @retriever.exchanges['NYSE'].first.sector)
    assert_equal('Technology', @retriever.exchanges['NYSE'].last.sector)
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_correct_industry
    @retriever.run('NYSE')
    assert_equal('Other Specialty Stores', @retriever.exchanges['NYSE'].first.industry)
    assert_equal('Semiconductors', @retriever.exchanges['NYSE'].last.industry)
  end
end

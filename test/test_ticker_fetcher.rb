require 'helper'

class TestTickerFetcher < Test::Unit::TestCase
  def setup
    @tf = TickerFetcher.new
    @tf.exchange_urls.each do |exchange, url|
      FakeWeb.register_uri(
        :get,
        url,
        :body => File.open("test/#{exchange.downcase}_test_data.csv").read)
    end
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_one_exchange
    @tf.retrieve('NYSE')
    assert_not_nil(@tf.exchanges['NYSE'])
    assert_nil(@tf.exchanges['NASD'])
    assert_nil(@tf.exchanges['AMEX'])
  end

  def test_retrieve_with_two_exchanges_returns_a_ticker_fetcher_with_two_exchanges
    @tf.retrieve('NYSE')
    @tf.retrieve('NASD')
    assert_not_nil(@tf.exchanges['NYSE'])
    assert_not_nil(@tf.exchanges['NASD'])
    assert_nil(@tf.exchanges['AMEX'])
  end

  def test_retrieve_with_all_exchanges_returns_a_ticker_fetcher_with_all_exchanges
    @tf.retrieve
    @tf.exchanges.keys.each do |exchange|
      assert_not_nil(@tf.exchanges[exchange])
    end
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_correct_tickers
    @tf.retrieve('NYSE')
    assert_equal('SC', @tf.exchanges['NYSE'].first[TickerFetcher::Symbol])
    assert_equal('ZGEN', @tf.exchanges['NYSE'].last[TickerFetcher::Symbol])
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_correct_company_names
    @tf.retrieve('NYSE')
    assert_equal('StupidCompany, Inc.', @tf.exchanges['NYSE'].first[TickerFetcher::Name])
    assert_equal('ZymoGenetics, Inc.', @tf.exchanges['NYSE'].last[TickerFetcher::Name])
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_correct_last_sale_price
    @tf.retrieve('NYSE')
    assert_equal('2.71', @tf.exchanges['NYSE'].first[TickerFetcher::LastSale])
    assert_equal('25', @tf.exchanges['NYSE'].last[TickerFetcher::LastSale])
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_correct_market_cap
    @tf.retrieve('NYSE')
    assert_equal('72858350', @tf.exchanges['NYSE'].first[TickerFetcher::MarketCap])
    assert_equal('85473000', @tf.exchanges['NYSE'].last[TickerFetcher::MarketCap])
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_correct_ipo_year
    @tf.retrieve('NYSE')
    assert_equal('1999', @tf.exchanges['NYSE'].first[TickerFetcher::IPOYear])
    assert_equal('2015', @tf.exchanges['NYSE'].last[TickerFetcher::IPOYear])
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_correct_sector
    @tf.retrieve('NYSE')
    assert_equal('Consumer Services', @tf.exchanges['NYSE'].first[TickerFetcher::Sector])
    assert_equal('Technology', @tf.exchanges['NYSE'].last[TickerFetcher::Sector])
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_correct_industry
    @tf.retrieve('NYSE')
    assert_equal('Other Specialty Stores', @tf.exchanges['NYSE'].first[TickerFetcher::Industry])
    assert_equal('Semiconductors', @tf.exchanges['NYSE'].last[TickerFetcher::Industry])
  end
end

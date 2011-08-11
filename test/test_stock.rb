require 'helper'
require 'lib/ticker_fetcher/stock'

class TestStock < Test::Unit::TestCase
  def setup
    @symbol = 'TESTING'
    @name = 'Testing, Inc.'
    @last_sale = '1.23'
    @market_cap = '123456789'
    @ipo_year = '2000'
    @sector = 'Consumer Services'
    @industry = 'Other Specialty Stores'
  end

  def test_create_a_stock
    stock = TickerFetcher::Stock.new([@symbol, @name, @last_sale, @market_cap, @ipo_year, @sector, @industry])
    assert_equal(@symbol, stock.symbol)
    assert_equal(@name, stock.name)
    assert_equal(@last_sale, stock.last_sale)
    assert_equal(@market_cap, stock.market_cap)
    assert_equal(@ipo_year, stock.ipo_year)
    assert_equal(@sector, stock.sector)
    assert_equal(@industry, stock.industry)
  end
end

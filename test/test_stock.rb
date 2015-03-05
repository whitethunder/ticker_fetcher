require 'helper'
require 'ticker_fetcher/stock'

class TestStock < Test::Unit::TestCase
  def setup
    @row = {
      'Symbol'    => 'TESTING',
      'Name'      => 'Testing, Inc.',
      'LastSale'  => '1.23',
      'MarketCap' => '123456789',
      'Sector'    => 'Consumer Services',
      'Industry'  => 'Other Specialty Stores'
    }
  end

  def test_create_a_stock
    stock = TickerFetcher::Stock.new(@row)
    assert_equal(@row['Symbol'], stock.symbol)
    assert_equal(@row['Name'], stock.name)
    assert_equal(@row['LastSale'], stock.last_sale)
    assert_equal(@row['MarketCap'], stock.market_cap)
    assert_equal(@row['Sector'], stock.sector)
    assert_equal(@row['Industry'], stock.industry)
  end
end

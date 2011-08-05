require 'helper'

class TestTickerFetcher < Test::Unit::TestCase
  def setup
    @t = TickerFetcher.new
    @t_mock = flexmock(@t)
    @t_mock.should_receive(:parse_exchange).with('NYSE', 'http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NYSE&render=download').and_return(@t_mock.send(:parse_csv, File.open("test/nyse_test_data.csv").read))
    @t_mock.should_receive(:parse_exchange).with('NASD', 'http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NASDAQ&render=download').and_return(@t_mock.send(:parse_csv, File.open("test/nasd_test_data.csv").read))
    @t_mock.should_receive(:parse_exchange).with('AMEX', 'http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=AMEX&render=download').and_return(@t_mock.send(:parse_csv, File.open("test/amex_test_data.csv").read))
#    @t_mock.should_receive(:retrieve).with_no_args.and_return({'NYSE' => File.open("test/nyse_test_data.csv").read, 'NASD' => File.open("test/nasd_test_data.csv").read, 'AMEX' => File.open("test/amex_test_data.csv").read})
#    @t_mock.should_receive(:retrieve).with('NYSE').and_return({'NYSE' => File.open("test/nyse_test_data.csv").read})
#    @t_mock.should_receive(:retrieve).with('NYSE', 'NASD').and_return({'NYSE' => File.open("test/nyse_test_data.csv").read, 'NASD' => File.open("test/nasd_test_data.csv").read})
  end

  def test_retrieve_with_one_exchange_returns_a_ticker_fetcher_with_the_correct_data
    @t_mock.retrieve('NYSE')
    assert_not_nil(@t_mock.exchanges['NYSE'])
    assert_nil(@t_mock.exchanges['NASD'])
    assert_nil(@t_mock.exchanges['AMEX'])
    assert_equal('SC', @t_mock.exchanges['NYSE'][0][0])
    assert_equal('AC-B', @t_mock.exchanges['NYSE'][1][0])
    assert_equal('C.A', @t_mock.exchanges['NYSE'][2][0])
  end

  def test_retrieve_with_two_exchanges_returns_a_ticker_fetcher_with_the_correct_data
    @t_mock.retrieve('NYSE')
    @t_mock.retrieve('NASD')
    assert_not_nil(@t_mock.exchanges['NYSE'])
    assert_not_nil(@t_mock.exchanges['NASD'])
    assert_nil(@t_mock.exchanges['AMEX'])
  end

  def test_retrieve_with_all_exchanges_returns_a_ticker_fetcher_with_the_correct_data
    @t_mock.retrieve
    assert_not_nil(@t_mock.exchanges['NYSE'])
    assert_not_nil(@t_mock.exchanges['NASD'])
    assert_not_nil(@t_mock.exchanges['AMEX'])
  end
end

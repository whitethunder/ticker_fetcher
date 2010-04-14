require 'rubygems'
require 'test/unit'
require 'flexmock/test_unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'ticker_fetcher'

class Test::Unit::TestCase
end

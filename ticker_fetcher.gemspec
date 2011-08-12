# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'ticker_fetcher/version'

Gem::Specification.new do |s|
  s.name = "ticker_fetcher"
  s.version = TickerFetcher::VERSION
  s.authors = ["Matt White"]
  s.email = ["mattw922@gmail.com"]
  s.homepage = "http://github.com/whitethunder/ticker_fetcher"
  s.summary = "Fetches all tickers and other useful data for NYSE, NASDAQ, and AMEX exchanges."
  s.description = "Retrieves tickers, names, and other useful data for all stocks listed on the 3 major US exchanges (NYSE, NASDAQ, AMEX)."
  s.rubyforge_project = "ticker_fetcher"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("fakeweb")
end


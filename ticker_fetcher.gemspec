# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ticker_fetcher"
  s.version = "0.4.0"
  s.authors = ["Matt White"]
  s.email = %q{mattw922@gmail.com}
  s.homepage = %q{http://github.com/whitethunder/ticker_fetcher}
  s.summary = %q{Fetches all tickers and other useful data for NYSE, NASDAQ, and AMEX exchanges.}
  s.description = %q{Retrieves tickers, names, and other useful data for all stocks listed on the 3 major US exchanges (NYSE, NASDAQ, AMEX).}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency(%q{fakeweb}, [">= 1.3.0"])
end


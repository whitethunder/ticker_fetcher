# -*- encoding: utf-8 -*-
#$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "ticker_fetcher"
  s.version = "0.5.0"
  s.authors = ["Matt White"]
  s.email = ["mattw922@gmail.com"]
  s.homepage = "http://github.com/whitethunder/ticker_fetcher"
  s.summary = "Fetches all tickers and other useful data for NYSE, NASDAQ, and AMEX exchanges."
  s.description = "Retrieves tickers, names, and other useful data for all stocks listed on the 3 major US exchanges (NYSE, NASDAQ, AMEX)."
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]
  s.license = "MIT"

  s.add_development_dependency("fakeweb", "~> 1.3.0", ">= 1.3.0")
end


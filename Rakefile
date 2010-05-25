require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ticker_fetcher"
    gem.summary = %Q{Fetches all tickers for NYSE, NASDAQ, and AMEX exchanges.}
    gem.description = %Q{Retrieves tickers, and names for all securities listed on the 3 major US exchanges (NYSE, NASDAQ, AMEX).}
    gem.email = "mattw922@gmail.com"
    gem.homepage = "http://github.com/whitethunder/ticker_fetcher"
    gem.authors = ["Matt White"]
    gem.add_development_dependency "fastercsv", ">= 1.5.0"
    gem.add_development_dependency "flexmock", ">= 0.8.2"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ticker_fetcher #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

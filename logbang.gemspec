# -*- encoding: utf-8 -*-
require File.expand_path('../lib/logbang/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jason Stirk"]
  gem.email         = ["jason@reinteractive.net"]
  gem.description   = %q{Scatter "log!" calls in your Rails app to make debugging and timing easy}
  gem.summary       = %q{Scatter "log!" calls in your Rails app to make debugging and timing easy}
  gem.homepage      = "http://github.com/jstirk/logbang"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "logbang"
  gem.require_paths = ["lib"]
  gem.version       = Logbang::VERSION

  gem.add_dependency('activesupport')
end

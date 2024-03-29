# -*- encoding: utf-8 -*-
require File.expand_path('../lib/tiktak/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tyler Green"]
  gem.email         = ["tyler.green2@gmail.com"]
  gem.description   = %q{Tic-tac-toe game}
  gem.summary       = %q{Tic-tac-toe game}
  gem.homepage      = "http://github.com/tylergreen"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "tiktak"
  gem.require_paths = ["lib"]
  gem.version       = Tiktak::VERSION
end

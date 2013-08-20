# -*- encoding: utf-8 -*-
require File.expand_path('../lib/useful_string_extensions/version', __FILE__)

Gem::Specification.new do |gem|
  gem.license       = "MIT"
  gem.authors       = ["Andrey"]
  gem.email         = ["railscode@gmail.com"]
  gem.description   = "useful_string_extensions"
  gem.summary       = "useful_string_extensions"
  gem.homepage      = "https://github.com/st-granat/useful_string_extensions.git"
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "useful_string_extensions"
  gem.require_paths = ["lib"]
  gem.version       = UsefulStringExtensions::VERSION
  gem.add_dependency "chardet", ">= 0.9.0"
  gem.add_dependency "russian", ">= 0.6.0"
  gem.add_dependency "unicode", ">= 0.4.2"
end

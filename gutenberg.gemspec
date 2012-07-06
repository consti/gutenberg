# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gutenberg/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Constantin Hofstetter"]
  gem.email         = ["Consti@Consti.de"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gutenberg"
  gem.require_paths = ["lib"]
  gem.version       = Gutenberg::VERSION

    # specify any dependencies here; for example:
  gem.add_development_dependency "rdf"
  gem.add_development_dependency "rdf-rdfxml"

  gem.add_runtime_dependency "rdf"
  gem.add_runtime_dependency "rdf-rdfxml"
end

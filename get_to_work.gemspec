# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'get_to_work/version'

Gem::Specification.new do |spec|
  spec.name          = "get_to_work"
  spec.version       = GetToWork::VERSION
  spec.authors       = ["Chris Rittersdorf"]
  spec.email         = ["chris.rittersdorf@collectiveidea.com"]

  spec.summary       = %q{Tag Harvest time entries with Pivotal Tracker information}
  spec.description   = %q{Tag Harvest time entries with Pivotal Tracker information}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "ruby-keychain"
  spec.add_dependency "pivotal-tracker"
  spec.add_dependency "harvested"
  spec.add_dependency "tracker_api", "~> 0.2.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rubocop"
end

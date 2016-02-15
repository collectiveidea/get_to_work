# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "get_to_work/version"

Gem::Specification.new do |spec|
  spec.name          = "get_to_work"
  spec.version       = GetToWork::VERSION
  spec.authors       = ["Chris Rittersdorf"]
  spec.email         = ["chris.rittersdorf@collectiveidea.com"]
  spec.required_ruby_version = ">= 2.2.0"

  spec.summary       = "Tag Harvest time entries with Pivotal Tracker information"
  spec.description   = "Tag Harvest time entries with Pivotal Tracker information"
  spec.homepage      = "https://github.com/collectiveidea/get_to_work"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "nokogiri", "~> 1.6", ">= 1.6.7.2"
  spec.add_dependency "ruby-keychain", "~> 0.3.2"
  spec.add_dependency "harvested", "~> 3.1", ">= 3.1.1"
  spec.add_dependency "tracker_api", "~> 0.2.12"
  spec.add_dependency "jira-ruby", "~> 0.1.17"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "bump"
  spec.add_development_dependency "guard-rspec"
end

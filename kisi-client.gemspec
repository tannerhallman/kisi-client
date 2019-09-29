# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kisi/client/version"

Gem::Specification.new do |spec|
  spec.name = "kisi-client"
  spec.version = Kisi::Client::VERSION
  spec.authors = ["Tanner H."]
  spec.email = ["tanner@coworksapp.com"]

  spec.summary = %q{Ruby Client for the KISI (Access Control System) API}
  spec.homepage = "https://github.com/tannerhallman/kisi-client"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "httparty", "~> 0.16.3"
  spec.add_runtime_dependency "rest-client", "~> 2.1.0"

  spec.add_development_dependency "bundler", "~> 1.16.6"
  spec.add_development_dependency "rake", "~> 12.0.0"
end

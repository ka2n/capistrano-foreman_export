# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/foreman/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-foreman"
  spec.version       = Capistrano::Foreman::VERSION
  spec.authors       = ["Katsuma Ito"]
  spec.email         = ["katsumai@gmail.com"]
  spec.description   = %q{Capistrano task for foreman}
  spec.summary       = %q{Capistrano task for foreman}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "capistrano", "~> 3.2"
  spec.add_development_dependency "rake"
end

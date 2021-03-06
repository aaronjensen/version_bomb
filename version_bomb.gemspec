# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version_bomb/version'

Gem::Specification.new do |spec|
  spec.name          = "version_bomb"
  spec.version       = VersionBomb::VERSION
  spec.authors       = ["Aaron Jensen"]
  spec.email         = ["aaronjensen@gmail.com"]
  spec.summary       = %q{Monkey patch safely-erish.}
  spec.description   = %q{Specify the gem or ruby version you are monkey patching and blow up if anyone upgrades it.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lttb/version'

Gem::Specification.new do |spec|
  spec.name          = "lttb"
  spec.version       = Lttb::VERSION
  spec.authors       = ["Jubke"]
  spec.email         = ["luebke.julian@gmail.com"]

  spec.summary       = %q{Largest-Triangle-Three-Buckets (LTTB) downsampling algorithm in Ruby.}
  spec.description   = %q{The code has been translated from the work of Sveinn Steinarsson in his plugin for Flot charts.
More information is available on [his page](https://github.com/sveinn-steinarsson/flot-downsample/),
and you can find the thesis describing the algorithm [here](http://skemman.is/handle/1946/15343).}
  spec.homepage      = "https://github.com/Jubke/lttb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

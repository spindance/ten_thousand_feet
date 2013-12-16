# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ten_thousand_feet/version'

Gem::Specification.new do |spec|
  spec.name          = "ten_thousand_feet"
  spec.version       = TenThousandFeet::VERSION
  spec.authors       = ["Kyle Suss"]
  spec.email         = ["susskyle@gmail.com"]
  spec.description   = %q{The 10,000ft Ruby API Client}
  spec.summary       = %q{Provides Ruby wrappers for the 10,000ft API.}
  spec.homepage      = "https://github.com/TackMobile/ten_thousand_feet"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "multi_json"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock", "1.8.0"
end

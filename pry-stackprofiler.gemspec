# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = 'pry-stackprofiler'
  spec.version       = '0.0.1'
  spec.authors       = ['Aidan Steele']
  spec.email         = ['aidan.steele@glassechidna.com.au']
  spec.summary       = %q{A pry plugin to facilitate easy benchmarking of Ruby code.}
  spec.homepage      = 'https://github.com/glassechidna/pry-stackprofiler'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1.0'

  spec.add_dependency 'pry', '~> 0.10'
  spec.add_dependency 'stackprofx', '~> 0.2'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end

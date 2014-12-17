# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quandl/slack/version'

Gem::Specification.new do |spec|
  spec.name          = 'quandl-slack'
  spec.version       = Quandl::Slack::VERSION
  spec.authors       = ['Najwa Azer']
  spec.email         = ['najwa.azer@gmail.com']
  spec.summary       = 'Builds custom Slack notifiers from a quandl/slack.yml file.'
  spec.description   = 'Builds custom Slack notifiers from a quandl/slack.yml file.'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-nc'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'pry-nav'
  spec.add_runtime_dependency 'quandl-config'
  spec.add_runtime_dependency 'slack-notifier', '>= 1.0'
end

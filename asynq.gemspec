# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asynq/version'

Gem::Specification.new do |gem|
  gem.name          = "asynq"
  gem.version       = Asynq::VERSION
  gem.authors       = ["Lucas Mazza"]
  gem.email         = ["lucastmazza@gmail.com"]
  gem.description   = %q{Asynchronous delivery of pre rendered e-mails}

  gem.bindir        = ["bin"]
  gem.executables   = ["asynq"]
  gem.files         = Dir["CHANGELOG.md", "LICENSE", "README.md", "lib/**/*"]
  gem.test_files    = Dir["spec/**/*.rb"]
  gem.require_paths = ["lib"]

  gem.add_dependency 'actionmailer',  '~> 3.2.9'
  gem.add_dependency 'activesupport', '~> 3.2.9'
  gem.add_dependency 'qu',            '~> 0.2.0'

  gem.add_development_dependency 'rspec', '~> 2.12.0'
end

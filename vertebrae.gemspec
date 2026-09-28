# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vertebrae/version'

Gem::Specification.new do |spec|
  spec.name        = 'vertebrae'
  spec.version     = Vertebrae::VERSION
  spec.authors     = ['Nathan Woodhull', 'Owens Ehimen']
  spec.email       = ['talk@controlshiftlabs.com']

  spec.summary     = 'API Client Infrastructure'
  spec.description = 'A set of low level infrastructure and reusable code for building API clients'
  spec.homepage    = 'https://github.com/controlshift/vertebrae'
  spec.license     = 'MIT'

  spec.extra_rdoc_files = [
    'LICENSE.txt',
    'README.md'
  ]

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.required_ruby_version = ['>= 3.3', '< 5.0']

  # Runtime dependencies
  spec.add_runtime_dependency 'activesupport', '>= 6.1'
  spec.add_runtime_dependency 'faraday', '~> 2.0'
  spec.add_runtime_dependency 'faraday-mashify', '~> 1.0'
  spec.add_runtime_dependency 'faraday-multipart', '~> 1.0'

  # Development dependencies
  spec.add_development_dependency 'bundler', '>= 2.0', '< 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 2.0'
  spec.add_development_dependency 'rubocop', '~> 1.0'
  spec.add_development_dependency 'webmock', '~> 3.0'

  spec.metadata['rubygems_mfa_required'] = 'true'
end


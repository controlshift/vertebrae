# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |s|
  s.name = "vertebrae".freeze
  s.version = "0.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nathan Woodhull".freeze]
  s.date = "2021-07-23"
  s.description = "A set of low level infrastructure and reusable code for building API clients".freeze
  s.email = "nathan@controlshiftlabs.com".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".github/workflows/ci.yml",
    ".rspec",
    ".rubocop.yml",
    ".ruby-gemset",
    ".ruby-version",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/api.rb",
    "lib/authorization.rb",
    "lib/base.rb",
    "lib/configuration.rb",
    "lib/connection.rb",
    "lib/constants.rb",
    "lib/core_ext/array.rb",
    "lib/model.rb",
    "lib/railties.rb",
    "lib/request.rb",
    "lib/response/raise_error.rb",
    "lib/response_error.rb",
    "lib/vertebrae.rb",
    "spec/api_spec.rb",
    "spec/configuration_spec.rb",
    "spec/dummy/client.rb",
    "spec/dummy/dummy.rb",
    "spec/logger_spec.rb",
    "spec/request_spec.rb",
    "spec/spec_helper.rb",
    "vertebrae.gemspec"
  ]
  s.homepage = "http://github.com/controlshift/vertebrae".freeze
  s.licenses = ["MIT".freeze]
  s.summary = "API Client Infrastructure".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 5.1.4"])
    s.add_runtime_dependency(%q<faraday>.freeze, ["~> 1"])
    s.add_runtime_dependency(%q<faraday_middleware>.freeze, ["> 0.12.2"])
    s.add_runtime_dependency(%q<hashie>.freeze, ["> 3.5.7"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec-its>.freeze, [">= 0"])
    s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 5.1.4"])
    s.add_dependency(%q<faraday>.freeze, ["~> 1"])
    s.add_dependency(%q<faraday_middleware>.freeze, ["> 0.12.2"])
    s.add_dependency(%q<hashie>.freeze, ["> 3.5.7"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-its>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0"])
  end
end


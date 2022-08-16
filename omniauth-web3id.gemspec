# frozen_string_literal: true

require_relative "lib/omniauth/web3id/version"

Gem::Specification.new do |spec|
  spec.name = "omniauth-web3id"
  spec.version = OmniAuth::Web3ID::VERSION
  spec.authors = ["Robin Bortlik"]
  spec.email = ["robinbortlik@gmail.com"]

  spec.summary = "OmniAuth extension for WEB3ID authentication"
  spec.homepage = "https://github.com/robinbortlik/OmniAuth-web3id"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/robinbortlik/omniauth-web3id"
  spec.metadata["changelog_uri"] = "https://github.com/robinbortlik/omniauth-web3id/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "omniauth"
  spec.add_runtime_dependency "omniauth-oauth2"

  spec.add_development_dependency "bundler", ">= 1.6"
  spec.add_development_dependency "pry", ">= 0.10.3"
  spec.add_development_dependency "rake", ">= 11.1.2"
  spec.add_development_dependency "rspec", ">= 3.4.0"
  spec.metadata["rubygems_mfa_required"] = "true"
end

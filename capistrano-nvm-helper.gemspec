# frozen_string_literal: true

require_relative "lib/capistrano/nvm/helper/version"

Gem::Specification.new do |spec|
  spec.name = "capistrano-nvm-helper"
  spec.version = Capistrano::Nvm::Helper::VERSION
  spec.authors = ["Encore Shao"]
  spec.email = ["encore@ekohe.com"]

  spec.summary = %q{NVM support for Capistrano 3.x}
  spec.description = %q{NVM support for Capistrano 3.x}
  spec.homepage = "https://github.com/ekohe/capistrano-nvm-helper"
  spec.license = "MIT"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ekohe/capistrano-nvm-helper/CODE_OF_CONDUCT.md"
  spec.metadata["changelog_uri"] = "https://github.com/ekohe/capistrano-nvm-helper/CHANGELOG.md"

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

  spec.add_dependency 'capistrano', '~> 3.1'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end

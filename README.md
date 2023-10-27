# Capistrano::Nvm::Helper

This gem provides idiomatic nvm support for Capistrano 3.x (and 3.x *only*).

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add capistrano-nvm-helper

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install capistrano-nvm-helper

## Usage

Require in `Capfile` to use the default task:

```ruby
require "capistrano/nvm-helper"
```

Configurable options in `config/deploy.rb`:

```ruby
set :nvm_type, :user # or :system
set :nvm_node, 'v14.16.1'

# in case you want to set nvm version from the file:
# set :nvm_node, File.read('.nvmrc').strip

set :nvm_prefix, "source #{fetch(:nvm_path)}/nvm.sh; "
set :nvm_map_bins, %w{rake gem bundle yarn rails}
```

## Rails

If you want to use nvm in your rails app deployment tasks (like `deploy:assets:precompile`), consider adding `rake` to `nvm_map_bins`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ekohe/capistrano-nvm-helper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ekohe/capistrano-nvm-helper/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Capistrano::Nvm::Helper project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ekohe/capistrano-nvm-helper/blob/main/CODE_OF_CONDUCT.md).

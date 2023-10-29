# Capistrano::Nvm::Helper

This gem provides idiomatic nvm support for Capistrano 3.x (and 3.x *only*).

difference between `capistrano-nvm`: avoid permission issues when multiple users deploy the same application by using different file names in the same directory for each deployer and stage.

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
set :nvm_type, :user
set :nvm_custom_path, "/opt/nvm"
set :nvm_node, 'v14.16.1'
set :nvm_map_bins, %w{node npm yarn webpack}
```

## Rails

If you want to use nvm in your rails app deployment tasks (like `deploy:assets:precompile`), pls adding `rake` to `nvm_map_bins`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ekohe/capistrano-nvm-helper. This project is intended to be a safe, welcoming space for collaboration, and contributors.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

# frozen_string_literal: true

namespace :nvm do
  task validate: :'nvm:wrapper' do
    on release_roles(fetch(:nvm_roles)) do
      nvm_node = fetch(:nvm_node)
      if nvm_node.nil?
        error "NVM: nvm_node is not set"
        exit 1
      end

      nvm_node_path = fetch(:nvm_node_path)
      nvm_node_path = [nvm_node_path] unless nvm_node_path.is_a?(Array)

      unless test(nvm_node_path.map {|p| "[ -d #{p} ]" }.join(" || "))
        error "NVM: #{nvm_node} is not installed or not found in any of #{nvm_node_path.join(" ")}"
        exit 1
      end
    end
  end

  task :map_bins do
    SSHKit.config.default_env.merge!({ node_version: "#{fetch(:nvm_node)}" })
    nvm_prefix = fetch(:nvm_prefix, -> { "#{fetch(:nvm_exec_path)}" } )

    fetch(:nvm_map_bins).each do |command|
      SSHKit.config.command_map.prefix[command.to_sym].unshift(nvm_prefix)
    end
  end

  task :wrapper do
    on release_roles(fetch(:nvm_roles)) do
      upload! StringIO.new(
        "#!/bin/bash -e\nsource \"#{fetch(:nvm_path)}/nvm.sh\"\nnvm use $NODE_VERSION\nexec \"$@\""
      ), "#{fetch(:nvm_exec_path)}"

      execute :chmod, "+x", "#{fetch(:nvm_exec_path)}"
    end
  end
end

Capistrano::DSL.stages.each do |stage|
  after stage, 'nvm:validate'
  after stage, 'nvm:map_bins'
end

namespace :load do
  task :defaults do
    set :nvm_path, -> {
      nvm_path = fetch(:nvm_custom_path)
      nvm_path ||= if fetch(:nvm_type, :user) == :system
        "/usr/local/nvm"
      else
        "$HOME/.nvm"
      end
    }

    set :nvm_roles, fetch(:nvm_roles, :all)
    set :nvm_node_path, -> {
      [
        "#{fetch(:nvm_path)}/#{fetch(:nvm_node)}",
        "#{fetch(:nvm_path)}/versions/node/#{fetch(:nvm_node)}"
      ]
    }
    set :nvm_map_bins, %w{node npm yarn}
    set :nvm_exec_path, -> {
      # Try to avoid permissions issues when multiple users deploy the same app
      # by using different file names in the same dir for each deployer and stage.
      suffix = %i(application stage local_user).map { |key| fetch(key).to_s }.join("-")
      "#{fetch(:tmp_dir)}/nvm-exec-#{suffix}.sh"
    }
  end
end
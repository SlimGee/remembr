require "mina/rails"
require "mina/git"

require "mina/rbenv"

set(:application_name, "remembr")
set(:domain, "remembr.welodge.co.zw")
set(:deploy_to, "/var/www/remembr.welodge.co.zw")
set(:repository, "git@github.com:SlimGee/remembr.git")
set(:branch, "main")

set(:user, "given")
set(:shared_dirs, fetch(:shared_dirs, []).push("tmp/sockets", "tmp/pids", "log"))
set(:shared_files, fetch(:shared_files, []).push("config/credentials/production.key"))

task(:remote_environment) do
  invoke(:"rbenv:load")
  command('export NVM_DIR="$HOME/.nvm"')
  command('[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"')
  command("nvm install 21")
  command("nvm use 21")
end

task(:setup) do
  command("rbenv install 3.2.4 --skip-existing")
  command("gem install bundler")
end

desc("Deploys the current version to the server.")
task(:deploy) do
  deploy do
    invoke(:"git:clone")
    invoke(:"deploy:link_shared_paths")
    invoke(:"bundle:install")
    invoke(:"rails:db_create")
    invoke(:"rails:db_migrate")

    command("yarn set version stable")
    command("yarn")
    invoke(:"rails:assets_precompile")
    invoke(:"deploy:cleanup")

    on(:launch) do
      in_path(fetch(:current_path)) do
        command("mkdir -p tmp/")
        command("touch tmp/restart.txt")
        command("systemctl --user restart #{fetch(:application_name)}-sidekiq.service")
        # command("bundle binstubs puma")
        invoke(:"puma:restart")
        invoke(:"sidekiq:restart")
      end
    end
  end
  # you can use `run :local` to run tasks on local machine before or after the deploy scripts
  run(:local) { command("echo \"Done!\"") }
end

namespace(:sidekiq) do
  desc("Start Sidekiq")
  task(:start) do
    in_path(fetch(:current_path)) do
      command("systemctl --user start #{fetch(:application_name)}-sidekiq.service")
    end
  end

  desc("Restart Sidekiq")
  task(:restart) do
    in_path(fetch(:current_path)) do
      command("systemctl --user restart #{fetch(:application_name)}-sidekiq.service")
    end
  end

  desc("Check Sidekiq status")
  task(:status) do
    command("systemctl --user status #{fetch(:application_name)}-sidekiq.service")
    command("journalctl --user -xeu #{fetch(:application_name)}-sidekiq.service")
  end

  desc("Tail Sidekiq logs")
  task(:log) do
    command("journalctl --user -u sidekiq.service -f")
  end

  desc("Setup Sidekiq systemd service")
  task(:setup) do
    puts("Setting up systemd service for Sidekiq..")
    path = fetch(:deploy_to)
    content = File.read("./config/sidekiq.service").gsub("<APP_PATH>", path)
    File.write("./tmp/sidekiq.service", content)
    run(:local) do
      command("scp ./tmp/sidekiq.service #{fetch(:user)}@#{fetch(:domain)}:~/.config/systemd/user/#{fetch(:application_name)}-sidekiq.service")
    end

    command("systemctl --user daemon-reload")
    command("systemctl --user enable #{fetch(:application_name)}-sidekiq.service")
  end
end

namespace(:puma) do
  desc("Start Puma")
  task(:start) do
    in_path(fetch(:current_path)) do
      # command("bundle binstubs puma")
      command("systemctl --user start #{fetch(:application_name)}-puma.service")
    end
  end

  desc("Restart Puma")
  task(:restart) do
    in_path(fetch(:current_path)) do
      command("systemctl --user restart #{fetch(:application_name)}-puma.service")
    end
  end

  desc("Check Puma status")
  task(:status) do
    command("systemctl --user status #{fetch(:application_name)}-puma.service")
    command("journalctl --user -xeu #{fetch(:application_name)}-puma.service")
  end

  desc("Tail Puma logs")
  task(:log) do
    command("journalctl --user -u #{fetch(:application_name)}-puma.service -f")
  end

  desc("Setup Puma systemd service")
  task(:setup) do
    puts("Setting up systemd service for Puma..")
    path = fetch(:deploy_to)
    content = File.read("./config/puma.service").gsub("<APP_PATH>", path)
    File.write("./tmp/puma.service", content)
    run(:local) do
      command("scp ./tmp/puma.service #{fetch(:user)}@#{fetch(:domain)}:~/.config/systemd/user/#{fetch(:application_name)}-puma.service")
    end

    command("touch #{fetch(:deploy_to)}/shared/tmp/pids/server.pid")
    command("systemctl --user daemon-reload")
    command("systemctl --user enable #{fetch(:application_name)}-puma.service")
  end
end

desc("Copy production key to server")
task(:copy_secrets) do
  run(:local) do
    command(
      "scp ./config/credentials/production.key #{fetch(:user)}@#{fetch(:domain)}:#{fetch(:deploy_to)}/shared/config/credentials/production.key"
    )
  end
end

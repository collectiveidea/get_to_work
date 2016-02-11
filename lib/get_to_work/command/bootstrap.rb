require "pivotal-tracker"

module GetToWork
  class Command
    class Bootstrap < GetToWork::Command
      KEYCHAIN_SERVICE = "GetToWork::PivotalTracker".freeze

      def run(_opts)
        check_for_config_file

        pt = GetToWork::Service::PivotalTracker.new

        @cli.say "\n\nStep #1 #{pt.display_name} Setup", :magenta
        @cli.say "-----------------------------", :magenta

        if pt.keychain
          pt.authenticate_with_keychain
        else
          username, password = prompt_for_login(pt)
          auth_with_service(service: pt, username: username, password: password)
        end

        project = prompt_select_project(pt)
        pt.save_config("project_id" => project.id)

        GetToWork::ConfigFile.save

        harvest = GetToWork::Service::Harvest.new(
          GetToWork::ConfigFile.instance.data
        )

        @cli.say "\n\nStep #2 #{harvest.display_name} Setup", :magenta
        @cli.say "-----------------------------", :magenta

        unless harvest.authenticate_with_keychain
          subdomain, username, password = prompt_for_subdomain_and_login(harvest)
          auth_with_service(
            service: harvest,
            username: username,
            password: password,
            subdomain: subdomain
          )
        end

        harvest_project = prompt_select_project(harvest)
        harvest_task = prompt_select_tasks(harvest, harvest_project)

        harvest.save_config(
          "project_id" => harvest_project.id,
          "task_id" => harvest_task["id"],
          "subdomain" => harvest.subdomain
        )

        GetToWork::ConfigFile.save
      end

      def check_for_config_file
        @config_file = GetToWork::ConfigFile.instance

        if @config_file
          unless @cli.yes?("Would you like to overwrite your existing #{GetToWork::ConfigFile.filename} file? [y/N]", :green)
            exit(0)
          end
        end
      end

      def prompt_for_login(service)
        username = @cli.ask "#{service.display_name} Username:", :green
        password = @cli.ask "#{service.display_name} Password:", :green

        [username, password]
      end

      def prompt_for_subdomain_and_login(service)
        subdomain = @cli.ask "#{service.display_name} Subdomain:", :green
        username, password = prompt_for_login(service)

        [subdomain, username, password]
      end

      def auth_with_service(service:, username:, password:, subdomain: nil)
        @cli.say "\n\nAuthenticating with #{service.display_name}...", :magenta

        begin
          service.authenticate(username: username, password: password, subdomain: subdomain)
          puts service.inspect
        rescue RestClient::Unauthorized
          @cli.say "Could not authenticate with #{service.display_name}", :red
          exit(1)
        end

        service.update_keychain(account: username)
      end

      def prompt_select_project(service)
        project_options = GetToWork::MenuPresenter.with_collection(service.projects)

        @cli.menu_ask(
          "\nSelect a #{service.display_name} project:",
          project_options,
          :green,
          limited_to: project_options.menu_limit
        )
      end

      def prompt_select_tasks(service, project)
        project_options = GetToWork::MenuPresenter.with_collection(project["tasks"])

        selected_project = @cli.menu_ask(
          "\nSelect a #{service.display_name} Task:",
          project_options,
          :green,
          limited_to: project_options.menu_limit
        )
      end
    end
  end
end

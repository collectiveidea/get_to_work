module GetToWork
  class Command
    class Bootstrap < GetToWork::Command
      def run
        check_for_config_file

        pt = GetToWork::Service::PivotalTracker.new

        shell.say "\n\nStep #1 #{pt.display_name} Setup", :magenta
        shell.say "-----------------------------", :magenta

        if pt.keychain
          pt.authenticate_with_keychain
        else
          username, password = prompt_for_login(pt)
          auth_with_service(service: pt, username: username, password: password)
        end

        project = prompt_select_project(pt)
        pt.save_config("project_id" => project.id)

        GetToWork::ConfigFile.save

        shell.say "\n\nStep #2 #{harvest_service.display_name} Setup", :magenta
        shell.say "-----------------------------", :magenta

        unless harvest_service.authenticate_with_keychain
          subdomain, username, password = prompt_for_subdomain_and_login(harvest_service)
          auth_with_service(
            service: harvest_service,
            username: username,
            password: password,
            subdomain: subdomain
          )
        end

        harvest_project = prompt_select_project(harvest_service)
        harvest_task = prompt_select_tasks(harvest_service, harvest_project)

        harvest_service.save_config(
          "project_id" => harvest_project.id,
          "task_id" => harvest_task["id"],
          "subdomain" => harvest_service.subdomain
        )

        GetToWork::ConfigFile.save
      end

      def check_for_config_file
        if config_file
          unless shell.yes?("Would you like to overwrite your existing #{GetToWork::ConfigFile.filename} file? [y/N]", :green)
            exit(0)
          end
        end
      end

      def prompt_for_login(service)
        username = shell.ask "#{service.display_name} Username:", :green
        password = shell.ask "#{service.display_name} Password:", :green, echo: false

        [username, password]
      end

      def prompt_for_subdomain_and_login(service)
        subdomain = shell.ask "#{service.display_name} Subdomain:", :green
        username, password = prompt_for_login(service)

        [subdomain, username, password]
      end

      def auth_with_service(service:, username:, password:, subdomain: nil)
        shell.say "\n\nAuthenticating with #{service.display_name}...", :magenta

        begin
          service.authenticate(username: username, password: password, subdomain: subdomain)
        rescue Service::UnauthorizedError
          shell.say "Could not authenticate with #{service.display_name}", :red
          exit(1)
        end

        service.update_keychain(account: username)
      end

      def prompt_select_project(service)
        project_options = GetToWork::MenuPresenter.with_collection(service.projects)

        menu_ask(
          "\nSelect a #{service.display_name} project:",
          project_options,
          :green,
          limited_to: project_options.menu_limit
        )
      end

      def prompt_select_tasks(service, project)
        tasks = project["tasks"].sort do |x, y|
          x[:name] <=> y[:name]
        end

        project_options = GetToWork::MenuPresenter.with_collection(tasks)

        menu_ask(
          "\nSelect a #{service.display_name} Task:",
          project_options,
          :green,
          limited_to: project_options.menu_limit
        )
      end
    end
  end
end

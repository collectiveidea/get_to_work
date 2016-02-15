module GetToWork
  class Service
    class Jira
      display_name "Jira"

      attr_reader :site, :context_path

      def api_client
        options = {
          username:  @username,
          password:  @password,
          site: @site,
          context_path: @context_path,
          auth_type:  :basic,
          read_timeout:  120
        }

        Jira::Client.new(options)
      end

      def authenticate(username:, password:)
        @username = username
        @password = password


      end

      def projects
        api_client.time.trackable_projects
      end

    end
  end
end

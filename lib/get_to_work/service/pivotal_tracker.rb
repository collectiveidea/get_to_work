# frozen_string_literal: true

require "tracker_api"
require "nokogiri"

module GetToWork
  class Service
    class PivotalTracker < GetToWork::Service
      display_name "Pivotal Tracker"

      def get_auth_token(user:, pass:)
        # POST
        uri = URI("https://www.pivotaltracker.com/services/v3/tokens/active")
        req = Net::HTTP::Get.new(uri)
        req.basic_auth user, pass

        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req)
        end

        case res
        when Net::HTTPUnauthorized
          raise Service::UnauthorizedError
        else
          res
        end

        # Parse the token
        xml = Nokogiri::XML(res.body)
        xml.xpath("//guid").first.text
      end

      def authenticate(username:, password:, subdomain:)
        token = get_auth_token(user: username, pass: password)
        set_client_token(token)
      end

      def authenticate_with_keychain
        if keychain
          set_client_token(keychain.password)
        end
      end

      def set_client_token(token)
        @api_token = token
      end

      def api_token
        @api_token ||= authenticate_with_keychain
      end

      def api_client
        @api_client ||= TrackerApi::Client.new(token: @api_token)
      end

      def projects
        @projects ||= get_projects
      end

      def get_projects
        api_client.projects
      end

      def story(story_id)
        api_client.project(@project_id).story(story_id)
      end
    end
  end
end

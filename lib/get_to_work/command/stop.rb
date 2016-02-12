module GetToWork
  class Command
    class Stop < GetToWork::Command
      def run
        if last_timer
          @cli.say "\nStopping your current timer...\n\n", :green
          result = harvest_service.stop_timer(last_timer)

          if result["id"]
            config_file.data.delete("last_timer")
            config_file.save
          end
        else
          @cli.say "\nYour timer has already been stopped.\n\n", :red
        end
      end
    end
  end
end

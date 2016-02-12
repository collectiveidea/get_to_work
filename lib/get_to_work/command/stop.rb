module GetToWork
  class Command
    class Stop < GetToWork::Command
      def run
        @cli.say "stopping your current timer"
      end
    end
  end
end

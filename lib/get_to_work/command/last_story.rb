module GetToWork
  class Command
    class LastStory < GetToWork::Command
      def run
        last_story_hash = config_file.data["last_story"]
        last_story_id = last_story_hash && last_story_hash["id"]

        shell.say(last_story_id)
      end
    end
  end
end

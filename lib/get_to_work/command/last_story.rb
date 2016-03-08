module GetToWork
  class Command
    class LastStory < GetToWork::Command
      def run
        pt_data = config_file.data["pivotal_tracker"]
        last_story_id = pt_data && pt_data["project_id"]
        shell.say(last_story_id)
      end
    end
  end
end

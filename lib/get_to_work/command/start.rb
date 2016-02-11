# frozen_string_literal: true

module GetToWork
  class Command
    class Start < GetToWork::Command
      def run
        story_id = parse_pt_id(@pt_id)

        configs = ConfigFile.instance.data
        pt = GetToWork::Service::PivotalTracker.new(configs)
        story = pt.story(story_id)

        harvest = GetToWork::Service::Harvest.new(configs)
        entry = {
          notes: "##{story.id}\n\n#{story.name}\n#{story.url}",
          project_id: harvest.project_id,
          task_id: harvest.task_id,
        }

        harvest.start_timer(entry)
      end

      def parse_pt_id(pt_id)
        pt_id.delete("#")
        pt_id.match(/\d+$/)[0]
      end
    end
  end
end

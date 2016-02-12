# frozen_string_literal: true

module GetToWork
  class Command
    class Start < GetToWork::Command
      def initialize(opts = {})
        super(opts)
        @pt_id = parse_pt_id(opts[:pt_id])
      end

      def run

        if @pt_id.nil?
          prompt_to_use_last_story
        end

        pt = GetToWork::Service::PivotalTracker.new(config_file.data)
        story = pt.story(@pt_id)

        harvest = GetToWork::Service::Harvest.new(config_file.data)
        entry = {
          notes: "##{story.id}\n\n#{story.name}\n#{story.url}",
          project_id: harvest.project_id,
          task_id: harvest.task_id,
        }

        timer = harvest.start_timer(entry)
        save_last_timer(timer)
        save_last_story(story)
      end

      def prompt_to_use_last_story
        last_story = config_file["last_story"]

        if last_story
          @cli.say "\nWould you like to start a timer for your last story?", :green
          @cli.say "  ##{last_story[:id.to_s]} ", [:bold, :cyan]
          @cli.say "#{last_story[:name.to_s]}", :magenta
          answer = @cli.yes? "\n[y/N]", :green

          if answer
            @pt_id = last_story["id"]
          else
            exit(0)
          end
        else
          @cli.say "Couldn't find your last started timer. Please specify a story id."
        end
      end

      def parse_pt_id(pt_id)
        return nil if pt_id.nil?

        pt_id.delete("#")
        pt_id.match(/\d+$/)[0]
      end

      def save_last_story(story)
        config_file[:last_story.to_s] = {
          "id" => story.id,
          "name" => story.name
        }

        config_file.save
      end

      def save_last_timer(timer)
        config_file[:last_timer.to_s] = timer.id
        config_file.save
      end
    end
  end
end

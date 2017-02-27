module GetToWork
  class CLI < Thor
    desc "bootstrap", "creates .gtw configuration for your current working directory"
    def bootstrap
      GetToWork::Command::Bootstrap.run
    end

    desc "start [--force] [<Pivotal Tracker Story ID or URL>]", "start working on a pivotal tracker story"
    method_option force: :boolean, required: false
    def start(pt_id=nil)
      if pt_id == "--force"
        pt_id = nil
        force_yes = true
      else
        force_yes = false
      end

      GetToWork::Command::Start.run(pt_id: pt_id, force: force_yes)
    end

    desc "stop", "#stop working on your current story"
    def stop
      GetToWork::Command::Stop.run
    end

    desc "last_story", "returns the id of the last story started"
    def last_story
      GetToWork::Command::LastStory.run
    end
  end
end

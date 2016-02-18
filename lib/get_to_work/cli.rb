module GetToWork
  class CLI < Thor

    desc "bootstrap", "creates .gtw configuration for your current working directory"
    def bootstrap
      GetToWork::Command::Bootstrap.run
    end

    desc "start <Pivotal Tracker Story ID or URL>", "start working on a pivotal tracker story"
    def start(pt_id = nil)
      GetToWork::Command::Start.run(pt_id: pt_id)
    end

    desc "stop", "#stop working on your current story"
    def stop
      GetToWork::Command::Stop.run
    end
  end
end

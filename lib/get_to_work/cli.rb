module GetToWork
  class CLI < Thor
    include GetToWork::Menu

    desc "bootstrap", "creates .gtw configuration for your current working directory"
    def bootstrap
      GetToWork::Command::Bootstrap.run(cli: self)
    end

    desc "start <Pivotal Tracker Story ID or URL>", "start working on a pivotal tracker story"
    def start(pt_id)
      GetToWork::Command::Start.run(cli: self, pt_id: pt_id)
    end

    desc "stop", "#stop working on your current story"
    def stop
      GetToWork::Command::Stop.run(cli: self)
    end
  end
end

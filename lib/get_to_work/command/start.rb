module GetToWork
  class Command
    class Start < GetToWork::Command
      def run
        cleaned_id = parse_pt_id(@pt_id)
        puts "PT id#{cleaned_id}"

        configs = ConfigFile.instance.data

        pt = GetToWork::Service::PivotalTracker.new(configs)
        harvest = GetToWork::Service::Harvest.new(configs)

        require 'pry'
        binding.pry
      end

      def parse_pt_id(pt_id)
        pt_id.gsub("#", "")
        pt_id.match(/\d+$/)[0]
      end
    end
  end
end

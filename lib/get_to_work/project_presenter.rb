class GetToWork::ProjectPresenter
  attr_reader :remote_id, :name

  def self.with_collection(projects)
    new(projects)
  end

  def initialize(projects)
    @projects = projects
  end

  def table
    @projects.map.with_index do |proj, i|
      [i+1, proj.name]
    end
  end

  def item_for(choice:)
    index = choice.to_i - 1
    @projects[index]
  end

  def menu_limit
    (1..@projects.count).map{|n| n.to_s}
  end
end

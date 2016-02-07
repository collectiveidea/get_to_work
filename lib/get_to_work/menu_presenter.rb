class GetToWork::MenuPresenter
  def self.with_collection(options)
    new(options)
  end

  def initialize(options)
    @options = options
  end

  def table
    @options.map.with_index do |option, i|
      [i+1, option.name]
    end
  end

  def item_for(choice:)
    index = choice.to_i - 1
    @options[index]
  end

  def menu_limit
    (1..@options.count).map{|n| n.to_s}
  end
end

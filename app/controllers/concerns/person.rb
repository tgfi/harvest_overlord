class Person

  attr_accessor :times
  attr_accessor :info

  def initialize(options = {})
    @info = options[:info] || []
    @times = options[:times] || []
  end

  def id
    @info.id
  end

end
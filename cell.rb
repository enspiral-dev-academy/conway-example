class Cell

  attr_accessor :alive, :neighbors

  def initialize
    @alive = rand > 0.8
    @neighbors = 0
  end

  def kill!
    @alive = false
  end

  def resurrect!
    @alive = true
  end

end
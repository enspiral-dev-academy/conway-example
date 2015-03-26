class Cell

  attr_accessor :alive, :neighbors

  def initialize
    @alive = rand > 0.8
    @neighbors = 0
  end

end
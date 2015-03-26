require_relative './cell.rb'

class Conway

  def initialize(size = 20)
    @size = size
    @grid = Array.new(@size) { Array.new(@size) { Cell.new } }
    @directions = [ [-1,-1], [-1, 0], [-1, 1], [ 0,-1], [ 0, 1], [ 1,-1], [ 1, 0], [ 1, 1] ]
  end

  def update_cells!
    @grid.each_with_index do |row,r|
      row.each_index do |c|
        update_cell!(r,c)
      end
    end
  end

  def update_cell!(r,c)

    if alive?(r,c) && (underpopulated?(r,c) || overpopulated?(r,c))
      @grid[r][c].alive = false
    end

    if !alive?(r,c) && resurrectable?(r,c)
      @grid[r][c].alive = true
    end

  end

  def tally_neighbors!
    @grid.each_with_index do |row, r|
      row.each_index do |c|
        tally_neighbors_for!(r,c)
      end
    end
  end

  def tally_neighbors_for!(r,c)
    @grid[r][c].neighbors = 0
    @directions.each do |i,j|
      if in_bounds?(r + i, c + j) && alive?(r + i, c + j)
        @grid[r][c].neighbors += 1
      end
    end
  end

  def in_bounds?(r,c)
    r.between?(0, @size - 1) && c.between?(0, @size - 1)
  end

  def alive?(r,c)
    @grid[r][c].alive
  end

  def overpopulated?(r,c)
    @grid[r][c].neighbors > 3
  end

  def underpopulated?(r,c)
    @grid[r][c].neighbors < 2
  end

  def resurrectable?(r,c)
    @grid[r][c].neighbors == 3 && !alive?(r,c)
  end

  def show
    system('clear')
    @grid.each do |row|
      row.each { |cell| print cell.alive ? "X|" : " |" }
      puts
    end
  end

end

conway = Conway.new(40)

loop do
  conway.show
  conway.tally_neighbors!
  conway.update_cells!
  sleep(0.1)
end
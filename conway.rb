require_relative './cell.rb'

class Conway

  def initialize(size = 20)
    @size = size
    @grid = Array.new(@size) { Array.new(@size) { Cell.new } }
    @directions = [ [-1,-1], [-1, 0], [-1, 1], [ 0,-1], [ 0, 1], [ 1,-1], [ 1, 0], [ 1, 1] ]
  end

  def cell(r,c)
    @grid[r][c]
  end

  def update_cells!
    @grid.each_with_index { |row,r| row.each_index { |c| update_cell!(r,c) } }
  end

  def update_cell!(r,c)
    cell(r,c).kill! if alive?(r,c) && (underpopulated?(r,c) || overpopulated?(r,c))
    cell(r,c).resurrect! if !alive?(r,c) && resurrectable?(r,c)
  end

  def tally_neighbors!
    @grid.each_with_index { |row, r| row.each_index { |c| tally_neighbors_for!(r,c) } }
  end

  def tally_neighbors_for!(r,c)
    cell(r,c).neighbors = 0
    @directions.each do |i,j|
      cell(r,c).neighbors += 1 if in_bounds?(r + i, c + j) && alive?(r + i, c + j)
    end
  end

  def in_bounds?(r,c)
    r.between?(0, @size - 1) && c.between?(0, @size - 1)
  end

  def alive?(r,c)
    cell(r,c).alive
  end

  def overpopulated?(r,c)
    cell(r,c).neighbors > 3
  end

  def underpopulated?(r,c)
    cell(r,c).neighbors < 2
  end

  def resurrectable?(r,c)
    cell(r,c).neighbors == 3 && !alive?(r,c)
  end

  def show
    system('clear')
    @grid.each do |row|
      row.each { |box| print box.alive ? "X|" : " |" }
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
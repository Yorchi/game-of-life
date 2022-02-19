# frozen_string_literal: true

module GameOfLife
  class Board
    attr_accessor :board

    def initialize(size)
      @size = size
      
      @grid = (1..size).map { |x| (1..size).map { |y| Cell.new(x, y) } }

      p @grid
    end

    def cells_total(size)
      @cells_total ||= size * size
    end


    def get_neighbors_by_cell(cell)
      neighbors = []
      x = cell.x
      y = cell.y
      puts cell.x
      puts cell.y
      
      # x = 1
      # y = 1
      y-1
      puts neighbors
      # neighbors << @grid[x - 1][y - 1] if x - 1 >= 1 && y - 1 >= 1
      # neighbors << @grid[x - 1][y] if x - 1 >= 1
      # neighbors << @grid[x - 1][y + 1] if x - 1 >= 1 && y + 1 <= @size

      # neighbors << @grid[x][y - 1] if y - 1 >= 1
      # neighbors << @grid[x][y + 1] if y + 1 <= @size
      
      # neighbors << @grid[x + 1][y - 1] if x + 1 <= @size && y - 1 >= 1
      # neighbors << @grid[x + 1][y] if x + 1 <= @size
      # neighbors << @grid[x + 1][y + 1] if x + 1 <= @size && y + 1 <= @size
      neighbors
    end

    # Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
    # Any live cell with two or three live neighbours lives on to the next generation.
    # Any live cell with more than three live neighbours dies, as if by overpopulation.
    # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    def generate_next_generation
      @grid.each_with_index do |row, x|
        row.each_with_index do |cell, y|
          neighbors = get_neighbors_by_cell(cell)
          
          alive_neighbors_total = neighbors.select(&:live?).count

          cell.die if cell.live? && alive_neighbors_total < 2

          cell.die if cell.live? && [2, 3].include?(alive_neighbors_total)

          cell.die if cell.live? && alive_neighbors_total > 3

          cell.live if cell.dead? && alive_neighbors_total == 3
        end
      end
    end

    def to_s
      grid = ''

      @grid.each do |row|
        row.each do |cell|
          grid += " #{cell}"
        end
        grid += "\n"
      end

      grid
    end
  end
end

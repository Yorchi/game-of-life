# frozen_string_literal: true

module GameOfLife
  class Board
    attr_accessor :board

    def initialize(size)
      @size = size - 1
      rows = cols = 0..@size

      @grid = rows.map do |x|
        cols.map { |y| Cell.new(x, y) }
      end
    end

    # Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
    # Any live cell with two or three live neighbours lives on to the next generation.
    # Any live cell with more than three live neighbours dies, as if by overpopulation.
    # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    def generate_next_generation
      next_generation = []
      neighbors_generator = neighbors_generator(@grid)

      @grid.each_with_index do |row, x|
        next_generation[x] = []
        row.each_with_index do |cell, y|
          alive_neighbors_total = neighbors_generator.generate(cell).alive_total
          
          if cell.live? && [2, 3].include?(alive_neighbors_total)
            status = :alive
          elsif cell.dead? && alive_neighbors_total == 3
            status = :alive
          else
            status = :dead
          end
          
          next_generation[x][y] = { status: status, cell: cell }
        end
      end

      next_generation.each_with_index do |row|
        row.each do |body|
          body[:status] == :alive ? body[:cell].live : body[:cell].die
        end
      end
    end

    def show
      grid = ''

      @grid.each do |row|
        row.each do |cell|
          grid += " #{cell}"
        end
        grid += "\n"
      end

      grid
    end

    def neighbors_generator(grid)
      GameOfLife::Generators::Neighbors.new(grid)
    end
  end
end

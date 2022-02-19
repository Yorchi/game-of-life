# frozen_string_literal: true

module GameOfLife
  module Generators
    class Neighbors
      attr_reader :neighbors

      def initialize(grid)
        @grid = grid
      end

      def generate(cell)
        x = cell.x
        y = cell.y

        @neighbors = []

        if has_upper_neighbors?(x)
          @neighbors << @grid[x - 1][y - 1] if has_left_neighbors?(x, y)
          @neighbors << @grid[x - 1][y]
          @neighbors << @grid[x - 1][y + 1] if has_right_neighbors?(x, y)
        end
  
        @neighbors << @grid[x][y - 1] if has_left_neighbors?(x, y)
        @neighbors << @grid[x][y + 1] if has_right_neighbors?(x, y)

        if has_lower_neighbors?(x)
          @neighbors << @grid[x + 1][y - 1] if has_left_neighbors?(x, y)
          @neighbors << @grid[x + 1][y]
          @neighbors << @grid[x + 1][y + 1] if has_right_neighbors?(x, y)
        end
        
        self
      end

      def has_upper_neighbors?(x)
        x > 0
      end

      def has_lower_neighbors?(x)
        x < @grid.length - 1
      end
      
      def has_left_neighbors?(x, y)
        y > 0
      end
      
      def has_right_neighbors?(x, y)
        y < @grid[x].length - 1
      end

      def alive_total
        @neighbors.select(&:live?).count
      end
    end
  end
end

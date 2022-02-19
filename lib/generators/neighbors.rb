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
          @neighbors << upper_neighbors(x)[y - 1] if has_left_neighbors?(x, y)
          @neighbors << upper_neighbors(x)[y]
          @neighbors << upper_neighbors(x)[y + 1] if has_right_neighbors?(x, y)
        end
  
        @neighbors << middle_neighbors(x)[y - 1] if has_left_neighbors?(x, y)
        @neighbors << middle_neighbors(x)[y + 1] if has_right_neighbors?(x, y)

        if has_lower_neighbors?(x)
          @neighbors << lower_neighbors(x)[y - 1] if has_left_neighbors?(x, y)
          @neighbors << lower_neighbors(x)[y]
          @neighbors << lower_neighbors(x)[y + 1] if has_right_neighbors?(x, y)
        end
        
        self
      end

      def upper_neighbors(x)
        @grid[x - 1]
      end

      def middle_neighbors(x)
        @grid[x]
      end

      def lower_neighbors(x)
        @grid[x + 1]
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

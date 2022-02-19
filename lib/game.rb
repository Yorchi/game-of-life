# frozen_string_literal: true

module GameOfLife
  class Game
    def initialize
      @board = Board.new(30)
    end

    def run
      loop do
        puts @board.show

        @board.generate_next_generation

        sleep(0.5)
        puts `clear`
      end
    end
  end
end

# frozen_string_literal: true

module GameOfLife
  class Game
    def initialize
      @board = Board.new(20)
    end

    def run
      generation = 1
      loop do
        puts "Generation #{generation}"
        puts @board.to_s
        generation += 1
        @board.generate_next_generation
        sleep(1)
        puts `clear`
      end
    end
  end
end

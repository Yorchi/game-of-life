# frozen_string_literal: true

module GameOfLife
  class Cell
    attr_reader :x, :y

    def initialize(x, y)
      @x = x
      @y = y
      @status = [:dead, :alive].sample
    end

    def die
      @status = :dead
    end

    def live
      @status = :alive
    end
    
    def dead?
      @status == :dead
    end

    def live?
      @status == :alive
    end

    def to_s
      live? ? '*' : ' '
    end
  end
end

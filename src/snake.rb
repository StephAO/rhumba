require_relative 'fifo'
require_relative 'coordinates'

class Snake

  attr_reader :score, :position

  def initialize(init_loc)
    @score = 0
    @position = FIFO.new([init_loc])
    @alive = true
  end

  def move(new_pos, food = false, occupied = false)
    if not occupied and @alive
      @position.insert(new_pos, food)
      @score += @position.size
    else
      @alive = false
    end
  end

  def find_coordinate(direction)
    # direction.downcase!

  end

  def find_next_move(board)

  end

end
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

  def next_coordinate(direction)
    direction.downcase!
    x, y = @position.first
    case direction
      when 'left'
        x -= 1
      when 'right'
        x += 1
      when 'up'
        y += 1
      when 'down'
        y -= 1
    end
    new_coord = Coordinates.new(x,y)
    if @position.include(new_coord)
      puts 'dead'
      @alive = false
    else
      new_coord
    end
  end

  def find_next_move(board)

  end

end
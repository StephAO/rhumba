require_relative 'fifo'
require_relative 'coordinates'

class Snake

  attr_accessor :alive, :score
  attr_reader :position

  #Class constant
  ALLOWED_MOVES||=['up','down','left','right']

  def initialize(init_loc)
    @score = 0
    @position = FIFO.new(init_loc)
    @alive = true
  end

  def move(new_pos, food = false)
    if @alive
      @position.insert(new_pos, food)
      @score += @position.size
    end
  end

  def next_coordinate(direction)
    direction.downcase!
    x = @position.first.x
    y = @position.last.y
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
  end

  def in_snake(coord)
    #checks if input coordinate is in snake
    @position.include(coord)
  end

  def get_head
    @position.first
  end

  def get_tail
    @position.last
  end

  def find_next_move(board)

  end

end
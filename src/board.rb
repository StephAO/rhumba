require_relative 'coordinates'
require_relative 'snake'

class Board

  attr_reader :height,:width,:food_loc

  #Class variables
  @@start_dist= 5 #minimum distance from other players starting points.
                  #must be greater than Snake @@start_snake_length
  @@start_snake_length=3
  @@start_timeout=10 #in attempts

  public

  def initialize(_players,_height,_width)
    #constructor
    @height=_height #int
    @width=_width #int
    @players = _players #list of Player classes
    gen_start()
    gen_food()
  end

  def gen_food
    #Sets a new food location, cannot be same as previous location or on edges

    @new_loc||=Coordinates.new(nil,nil) #so it only has to be created once
    @food_loc||=@new_loc.clone
    rand_loc(@new_loc)

    if defined? @food_loc
      until @new_loc!=@food_loc && @players.all? {|p| not(p.my_snake.in_snake(@new_loc))}
        rand_loc(@new_loc)
      end
    end

    @food_loc.set_xy(@new_loc.x,@new_loc.y)

  end

  def gen_start
    # generate start locations
    start_loc=Coordinates.new(nil,nil)
    attempts=0

    for i in 0...@players.length
      rand_loc(start_loc)
      if i!=0 then
        while true
            if @players[0...i].all? { |p| Coordinates.distance(start_loc,p.my_snake.get_tail)>@@start_dist } then
              break
            end
            rand_loc(start_loc)
            attempts+=1
            if attempts>@@start_timeout then
              puts "ERROR: Gen_start max placement attempts of #{@@start_timeout} exceeded."
              return
            end
        end
      end

      @players[i].gen_snake([start_loc.clone])
      #gen rest of snake
      (@@start_snake_length - 1).times do
        while true
          rand_coord = @players[i].my_snake.next_coordinate(Snake::ALLOWED_MOVES[rand(0...Snake::ALLOWED_MOVES.length)])
          if not(@players[i].my_snake.in_snake(rand_coord)) && in_board(rand_coord) then
            break
          end
        end
        #not using move because don't want to increase score
        @players[i].my_snake.position.insert(rand_coord.clone, true) #true so that snake grows.
      end

    end

  end

  def in_board(c)
    #checks if coordinate is in board
    (c.x >= 0) && (c.x < @width) && (c.y >= 0) && (c.y < @height)
  end

  private

  def rand_loc(c)
    #randomizes coordinate within board
    c.set_xy(rand(0...@width), rand(0...@height))
  end

end
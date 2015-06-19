require_relative 'coordinates'
require_relative 'snake'

class Board

  attr_reader :height,:width,:food_loc

  #Class variables
  @@start_dist= 5 #minimum distance from other players starting points
  @@start_timeout=10 #in attempts

  public

  def initialize(_players,_height,_width)
    #constructor
    @height=_height #int
    @width=_width #int
    @players = _players #list of Player classes
    gen_food()
  end

  def gen_food
    #Sets a new food location, cannot be same as previous location or on edges
    #TO DO: Need to handle cases where snake is already on generated location

    @new_loc||=Coordinates.new(nil,nil) #so it only has to be created once
    @food_loc||=@new_loc.clone
    rand_loc(@new_loc)

    if defined? @food_loc
      until (@new_loc.x!=@food_loc.x)&&(@new_loc.y!=@food_loc.y)
        rand_loc(@new_loc)
        puts @new_loc.x.to_s<<" "<<@new_loc.y.to_s
      end
    end

    @food_loc.set_xy(@new_loc.x,@new_loc.y)

  end

  def gen_start
    #TO DO: Fix position access
    # generate start locations
    start_loc=Coordinates.new(nil,nil)
    attempts=0

    for i in 0...@players.length
      rand_loc(start_loc)
      if i==0 then
        @players[i].gen_snake(start_loc.clone)
        next
      end
      while true
          if @players[0...i].all? { |p| Coordinates.distance(start_loc,p.my_snake.position.arr[0])>@@start_dist } then
            @players[i].gen_snake(start_loc)
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

  end

  private

  def rand_loc(c)
    #randomizes coordinate not on edges
    c.set_xy(rand(1...@width), rand(1...@height))
  end

end
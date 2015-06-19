require_relative 'coordinates'
require 'timeout'

class Board

  attr_reader :height,:width,:food_loc

  #Class variable
  @@start_dist= 5 #minimum distance from other players starting points
  @@start_timeout=5 #in seconds

  public

  def initialize(_height,_width)
    #constructor
    # TO DO: add player list input
    @height=_height
    @width=_width
    #@players = _players #list of player classes
    gen_food()
  end

  def gen_food()
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
    # UNTESTED
    # generate start locations
    start_loc=Coordinates.new(nil,nil)
    for i in players.length
      rand_loc(start_loc)
      if i==0 then
        players[i].set_snake_start(start_loc)
        next
      end

      end
      while true
        begin
          Timeout::timeout(timeout_in_seconds) do
              if players[0...i].all? { |p| Coordinates.distance(start_loc,p.get_snake_start)>@@start_area } then
                players[i].set_snake_start(start_loc)
                break
              end
              rand_loc(start_loc)
          end
        rescue Timeout::Error
          puts "Timeout Error: Start Position Generation"
          return
        end
    end

  end

  private

  def rand_loc(c)
    #randomizes coordinate not on edges
    c.set_xy(rand(1...@width), rand(1...@height))
  end

end
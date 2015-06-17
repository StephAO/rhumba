require_relative 'coordinates'

class Board

  attr_reader :height,:width,:food_loc

  public

  def initialize(_height,_width)
    #constructor
    @height=_height
    @width=_width
    gen_food()
  end

  def gen_food()
    #Sets a new food location, cannot be same as previous location or on edges
    #TO DO: Need to handle cases where snake is already on generated location

    x,y=rand_loc

    if defined? @food_loc
      until (x!=@food_loc.x)&&(y!=@food_loc.y)
        x,y=rand_loc()
      end
        @food_loc.set_xy(x,y)
    else
      @food_loc=Coordinates.new(x,y)
    end

  end

  private

  def rand_loc()
    #generates random location NOT on edges
    return rand(1...@width), rand(1...@height)
  end

end
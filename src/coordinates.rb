class Coordinates

  attr_accessor :x,:y

  def initialize(_x,_y)
    set_xy(_x,_y)
  end

  def set_xy(_x,_y)
    @x,@y=_x,_y
  end

  def magnitude
    (@x**2+@y**2)**0.5
  end

  def self.distance(c1,c2)
    #static class measuring distance between two sets of coordinates
    ((c1.x-c2.x)**2+(c1.y-c2.y)**2)**0.5
  end

  def coords_print
    print "(#{@x},#{@y})"
  end

  def ==(other)
    return @x == other.x && @y == other.y
  end

end
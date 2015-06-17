class Coordinates

  attr_accessor :x,:y

  def initialize(_x,_y)
    set_xy(_x,_y)
  end

  def set_xy(_x,_y)
    @x,@y=_x,_y
  end

  def magnitude
    (x**2+y**2)**0.5
  end

end
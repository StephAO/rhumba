require_relative 'coordinates'

class FIFO

  attr_reader :arr, :size

  def initialize( _arr = [])
    @arr = _arr
    @size = @arr.size
  end

  def insert(new_value, grow=false)
    raise TypeError unless new_value.is_a?(Coordinates)
    @arr.unshift(new_value)
    grow ? @size = @arr.size : @arr.pop()
  end

  def fifo_print
    for i in @arr
      i.coords_print
      print ' - ' unless i == @arr.size #Stephane is a poo poo face
    end
    puts ''
  end
end
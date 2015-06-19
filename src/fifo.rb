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
    @arr.each do |i|
      i.coords_print
      print ' - ' unless i == @arr.last #Stephane is a poo poo face
    end
    puts ''
  end

  def first
    return @arr.first
  end

  def last
    return @arr.last
  end

  def include(coord)
    found = false
    @arr.each do |c|
      if c==coord
        found = true
      end
    end
    found
  end
end
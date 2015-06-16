class FIFO

  attr_accessor :size
  attr_reader :arr

  def initialize( _arr = [])
    @arr = _arr
    @size = @arr.size
  end

  def insert(_new_value, _grow=false)
    # raise TypeError unless _new_value.is_a?(Array)
    @arr.unshift(_new_value)
    _grow ? @size = @arr.size : @arr.pop()
  end

  def print()
    puts 'size = ' + @size.to_s
    puts @arr.join(" ")
    puts '-------------------------------------------------------------------------------------------------------------'
  end
end
class FIFO

  attr_reader :arr, :size

  def initialize( _arr = [])
    @arr = _arr
    @size = @arr.size
  end

  def insert(new_value, grow=false)
    # raise TypeError unless _new_value.is_a?(Array)
    @arr.unshift(new_value)
    grow ? @size = @arr.size : @arr.pop()
  end

  def print()
    puts 'size = ' + @size.to_s
    puts @arr.join(" ")
    puts '-----------'
  end
end
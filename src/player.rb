class Player

  attr_reader :name

  Data = Struct.new(:wins, :losses, :deaths, :avg_points) do
    def print
      puts 'test'
    end
  end

  def initialize(_name, _id)
    @name = _name #players name (string)
    @id = _id     #players id (int)
    @data = Data.new(0,0,0,0)
  end

  def next_move()

  end
end
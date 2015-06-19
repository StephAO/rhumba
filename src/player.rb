require_relative 'Snake'

class Player

  attr_reader :name,:my_snake

  #Class variables
  @@num_players=0

  Data = Struct.new(:wins, :losses, :deaths, :avg_points) do
    def print
      puts 'test'
    end
  end

  def initialize(_name)
    @name = _name #players name (string)
    @id = @@num_players     #players id (int)
    @data = Data.new(0,0,0,0)
    @@num_players+=1
  end

  def gen_snake(init_loc)
    @my_snake=Snake.new(init_loc)
  end

  def next_move()

  end
end
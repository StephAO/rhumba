require_relative 'Snake'
require_relative 'Board'

class Player

  attr_reader :name,:my_snake, :mem_move, :num_snakes

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
    @num_snakes=0
  end

  def gen_snake(init_loc)
    @num_snakes+=1
    @my_snake=Snake.new(init_loc)
  end

  def call_ai
    #Call AI to get next move
    #Done through command line
    #Inputs to AI:
    # (1) Board Height,Board Width,Number of Players, Number of Snakes
    # (2) Player(owner),Snake 1 Tail,...,Snake 1 Head -> Coordinates are of form x,y => 1,x,y,x1,y2,x2,x3,y3,...
    # (3) Player(owner),Snake 2 Tail,...,Snake 2 Head
    # (4) ...repeat for all snakes
    # (5) Food Location x,Food Location Y
    # Note: Lists are comma separated, inputs are space separated
    #Output from AI: "up","down","left" or right

    setup_out=''

    out=`date /t`
  end

  def snake_death
    @my_snake.alive = false
  end
end
require_relative 'Snake'
require_relative 'Board'

class Player

  attr_reader :name, :id, :my_snake, :mem_move, :num_snakes, :ai_debug

  #Class variables
  @@num_players=0

  def initialize(_name,_cmd_str)
    @name = _name #players name (string)
    @id = @@num_players     #players id (int)
    @@num_players+=1
    @num_snakes=0
    @cmd_str=_cmd_str
    init_ai
  end

  def gen_snake(init_loc)
    @num_snakes+=1
    @my_snake=Snake.new(init_loc)
  end

  def get_data
    #returns a string of current player data
    #used for call_ai
    out_str=[@id,(@my_snake.alive ? 1:0),@my_snake.score].join(",")
    @my_snake.position.arr.each{|c| out_str<<",#{c.x},#{c.y}"}

    return out_str
  end

  def init_ai
    #pass snake id to player
    out=@cmd_str+" -i "+@id.to_s
    @ai_debug=`#{out}` #shell command
  end

  def call_ai(data_str)
    #Call AI to get next move
    #Done through command line
    #Inputs to AI:
    # (0) Your player ID
    # (1) Board Width,Board Height, Number of Snakes
    # (2) Food Location x,Food Location Y
    # (3) Player(owner) ID,Alive/Dead,Score,Snake Head,...,Snake Tail #send alive players first then dead
    # (4) ...repeat for all snakes -> Coordinates are of form x,y => ID,Score,x,y,x1,y2,x2,x3,y3,...
    # Note: Lists are comma separated, inputs are space separated
    #Output from AI: "up","down","left" or right

    out=@cmd_str+" -s #{id} "+data_str
    ai_out=`#{out}`
    @ai_debug=ai_out.lines.to_a[0...-1].join
    @mem_move=@my_snake.next_coordinate(ai_out.lines.last)
    #puts "#{id}: #{ai_debug} ==> #{ai_out.lines.last}"
  end

  def snake_death
    @my_snake.alive = false
  end

  def commit(grow=false)
    @my_snake.move(mem_move, grow)
  end
end
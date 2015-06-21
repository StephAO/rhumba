require_relative 'board'
require_relative 'snake'
require_relative 'player'

class Game

  @@num_games = 0

  MIN_BOARD_SIZE_PER_PLAYER = 10
  MAX_BOARD_SIZE = 1000

  def initialize(_players)
    @players = _players
    @game_id = @@num_games
    @@num_games += 1
    n = rand(MIN_BOARD_SIZE_PER_PLAYER*(_players.size)...MAX_BOARD_SIZE)
    m = rand(MIN_BOARD_SIZE_PER_PLAYER*(_players.size)...MAX_BOARD_SIZE)
    @board = Board.new(_players, n, m)
    start_game
  end

  def start_game
    alive_players = @players
    while alive_players
      moves = []
      alive_players.each do |ap|
        moves.shift(ap.id, ap.next_move())
      end


    end
  end

  def next_turn(alive_players,dead_players)
    #generate data to be passed to AI

    #board and num snake
    num_snakes=0
    @players.each{|p| num_snakes+=p.num_snakes}
    out_data=[@board.height,@board.width,num_snakes].join(",")

    #food info
    out_data<<" #{@board.food_loc.x},#{@board.food_loc.y}"

    l_get_data= lambda{|p| out_data<<" "<<p.get_data}
    alive_players.each(&l_get_data)
    dead_players.each(&l_get_data)

    puts out_data

    #Call AI of each player with board+snake info
    alive_players.each{|p| p.call_ai(out_data)}
  end
end
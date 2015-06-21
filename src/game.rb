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
    @n = rand(MIN_BOARD_SIZE_PER_PLAYER*(_players.size)...MAX_BOARD_SIZE)
    @m = rand(MIN_BOARD_SIZE_PER_PLAYER*(_players.size)...MAX_BOARD_SIZE)
    @board = Board.new(_players, @n, @m)
    start_game
  end

  def start_game
    alive_players = @players
    dead_players = []
    until alive_players.empty?
      next_move(alive_players, dead_players)
      taken = []
      alive_players.each { |p| taken.insert(0, p.my_snake.position)} #change to @players to include carcasses
      alive_players.each { |p| taken.push(p.mem_move)}
      alive_players.each do |p|
        if !p.check_move
          p.snake_death
          alive_players.delete(p)
          dead_players.push(p)
        end
      end
      if alive_players.size == 1
        if check_winning == alive_players.first
          puts 'The winner is ' + alive_players.first.name
          break
        end
      end
    end
  end


  def check_move(player, taken)
    move = player.mem_move
    if move
      if taken.include? move
        return false
      elsif move == @board.food_loc
        player.commit(grow=true)
      else
        player.commit
      end
    end
    true
  end

  def check_winning
    best_score = 0
    winner = nil
    @players.each do |p|
      if p.my_snake.score > best_score
        winner = p
      end
    end
  end

  def next_turn
    #generate data to be passed to AI
    #UNTESTED
    num_snakes=0
    @players.each{|p| num_snakes+=p.num_snakes}
    out_data=[@board.height,@board.width,num_snakes]
    puts out_data
    #need to call on each player -> TO DO
  end

end

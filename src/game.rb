require_relative 'board'
require_relative 'snake'
require_relative 'player'

class Game

  @@num_games = 0

  MIN_BOARD_SIZE_PER_PLAYER = 10
  MAX_BOARD_SIZE = 100

  def initialize(_players)
    @players = _players
    @game_id = @@num_games
    @@num_games += 1
    @n = rand(MIN_BOARD_SIZE_PER_PLAYER*(_players.size)...MAX_BOARD_SIZE) #y
    @m = rand(MIN_BOARD_SIZE_PER_PLAYER*(_players.size)...MAX_BOARD_SIZE) #x
    @board = Board.new(_players, @n, @m)
    start_game
  end

  def start_game
    alive_players = @players.clone
    dead_players = []
    until alive_players.empty?
      puts @board.food_loc.coords_print
      next_move(alive_players, dead_players)
      taken = []
      alive_players.each do |p|
        print p.name + ' - '
        puts p.my_snake.snake_print
        p.my_snake.position.arr.each { |c| taken.push(c)} #change to @players to include carcasses
      end
      alive_players.each do |p|
        death_square = taken.clone
        other_players = alive_players - [p]
        other_players.each { |p| death_square.push(p.mem_move)}
        if !check_move(p, death_square)
          p.snake_death
          dead_players.push(p)
        end
      end
      #MAKE NICER
      alive_players = alive_players - dead_players
      @players = alive_players + dead_players

      if alive_players.size == 1
        puts "The last player left alive is #{alive_players.first.name}, #{check_winning.name} has the most points,"
        if check_winning.id == alive_players.first.id
          break
        end
      end
    end
    winner = check_winning
    puts "The winner is #{winner.name} with a score of #{winner.my_snake.score}"
  end


  def check_move(player, taken)
    print player.name
    player.mem_move.coords_print
    move = player.mem_move
    if move
      illegal = true
      if (move.x > 0 && move.x < @m) and (move.y > 0 && move.y < @n)
        illegal = false
      end
      if taken.include? move or illegal
        puts 'I died'
        return false
      elsif move == @board.food_loc
        puts 'I ate'
        player.commit(grow=true)
      else
        puts 'I moved'
        player.commit
      end
    else
      puts 'ERROR: check_move: no move saved in player'
    end
  end

  def check_winning
    best_score = -1
    winner = nil
    @players.each do |p|
      if p.my_snake.score > best_score
        winner = p
        best_score = p.my_snake.score
      end
    end
    return winner
  end

  def next_move(alive_players,dead_players)
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

    # puts out_data

    #Call AI of each player with board+snake info
    alive_players.each{|p| p.call_ai(out_data)}
  end

end

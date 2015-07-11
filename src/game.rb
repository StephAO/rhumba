require_relative 'board'
require_relative 'snake'
require_relative 'player'

class Game

  @@num_games = 0

  MIN_BOARD_SIZE_PER_PLAYER = 9
  MAX_BOARD_SIZE = 20
  GAME_DIR= "../games/"

  attr_reader :board

  def initialize(_players)
    @@num_games += 1
    @players = _players
    @game_id = @@num_games
    @n = rand(MIN_BOARD_SIZE_PER_PLAYER*(_players.size)...MAX_BOARD_SIZE) #y
    @m = rand(MIN_BOARD_SIZE_PER_PLAYER*(_players.size)...MAX_BOARD_SIZE) #x
    @board = Board.new(_players, @n, @m)
    @game_loc=GAME_DIR+@game_id.to_s+".game"
    @num_food = 1
    start_game
  end

  def start_game
    alive_players = @players.clone
    dead_players = []
    turn=0
    until alive_players.empty?
      if turn%25==0
        puts "Turn: #{turn}"
      end
      #write data to file
      write_data(turn)
      next_move(alive_players, dead_players)
      taken = []
      alive_players.each do |p|
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
      if @num_food % 5 == 0
        alive_players.each do |p|
          if p.my_snake.starve
            puts 'a snake died'
            p.snake_death
            dead_players.push(p)
          end
        end
        @num_food = 1
      end
      #TODO: MAKE NICER
      alive_players = alive_players - dead_players
      # @players = alive_players + dead_players

      if alive_players.size == 1
        # puts "The last player left alive is #{alive_players.first.name}, #{check_winning.name} has the most points,"
        if check_winning.id == alive_players.first.id
          break
        end
      end
      turn+=1
    end
    winner = check_winning
    winner.add_win
    (@players - [winner]).each {|q| q.add_loss}
    puts "The winner is #{winner.name} with a score of #{winner.my_snake.score}"
    write_data(winner.name)
    @players.each {|p| p.delete_snake}
  end


  def check_move(player, taken)
    move = player.mem_move
    if move
      illegal = false
      if (move.x < 0 && move.x >= @m) and (move.y < 0 && move.y >= @n)
        illegal = true
      end
      @players.each do |p|
        if p.my_snake.in_snake(move)
          illegal = true
        end
      end
      if taken.include? move or illegal
        return false
      elsif move == @board.food_loc
        player.commit(grow=true)
        @board.gen_food
        @num_food += 1
      else
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
    out_data=[@board.width,@board.height,num_snakes].join(",")

    #food info
    out_data<<" #{@board.food_loc.x},#{@board.food_loc.y}"

    l_get_data= lambda{|p| out_data<<" "<<p.get_data}
    alive_players.each(&l_get_data)
    dead_players.each(&l_get_data)

    # puts out_data
    #Call AI of each player with board+snake info
    alive_players.each{|p| p.call_ai(out_data)}
  end

  def write_data(turn)
    #stores game data in appropriate directory
    #directory = game_id
    #FORMAT:
    # Line 0: Board Width, Board Height, Number of Players, Number of Snakes
    # Line 1: List of player names
    # Line 2: Turn Number. Starts at 0. String is of form "#0" or "#1"
    # Line 3: Food location
    # Line 4: Player score
    # Line 5-?: Snake x, Snake y, x, y x, y. NOTE: if snake is dead & no carcasses then blank line
    # Repeat from Line 2 for each frame
    # Line END: Send name of winner after snake location. i.e. #END\n....\nBOB

    if turn==0 then
      #open file
      f=File.new(@game_loc,"w")

      #Line 0
      num_snakes=0
      @players.each{|p| num_snakes+=p.num_snakes}
      f.write([@board.width,@board.height,@players.length,num_snakes].join(",")<<"\n")

      #Line 1
      f.write(@players.map{|p| p.name}.join(","))
    end

    f||=File.open(@game_loc,"a+") #append if not creating

    if turn.is_a? String
      f.write("\n#END\n")
    else
      #Line 2
      f.write("\n##{turn}\n")
    end
    #Line 3 food location
    f.write("#{@board.food_loc.x},#{@board.food_loc.y}\n")

    #Line 4
    f.write(@players.map{|p| p.my_snake.score}.join(",")<<"\n")
    #Line 5
    f.write(@players.map{|p| p.my_snake.position.arr.map{|c| "#{c.x},#{c.y}"}.join(",")}.join("\n"))
    if turn.is_a? String
      #Line 5
      f.write("\n#{turn}\n")
    end
    f.close()
  end
end


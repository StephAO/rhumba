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
end
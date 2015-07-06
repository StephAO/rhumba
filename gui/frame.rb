require 'gosu'

NAME_SEPARATION = 20
TILE_SIZE = 8
TILE_SEPARATION = 2
BUFFER = 20
FONT_SIZE = 30

## COLORS ##
WHITE = 0xffffffff
GRAY = 0xff808080
RED = 0xffff0000
BLUE = 0xff0000ff
GREEN = 0xff00ff00
YELLOW = 0xffffff00
CYAN = 0xff00ffff
FUCHSIA = 0xffff00ff


PLAYER_COLOR = {0=>RED, 1=>BLUE, 2=>GREEN, 3=>YELLOW, 4=>CYAN, 5=>FUCHSIA}

class Frame

  @@names = Array.new

  # h and w correspond to square indices NOT the game board dimensions
  @@h = 0
  @@w = 0

  def initialize(_food_loc, _scores, _snakes, _winner=nil)
    @food_loc = _food_loc
    @scores = _scores
    @snakes = _snakes
    @winner = _winner
  end

  # DRAWS THE BOARD
  def draw(window, fonts)

    # DRAW NAMES AND SCORES
    i = 0
    x = 0
    y = 0
    fonts.each do |f|
      _str = "#{@@names.at(i)}: #{@scores.at(i)}"
      _color = PLAYER_COLOR[i]
      f.draw(_str, x, y, i, scale_x=1, scale_y=1, color=_color)
      x += f.text_width(_str) + NAME_SEPARATION
      i += 1
    end

    # DRAW GAME BOARD
    y = FONT_SIZE + BUFFER + (@@h -1)*TILE_SIZE
    x = BUFFER + TILE_SEPARATION/2
    @@w.times do |i|
      @@h.times do |j|

        # PICK COLOR ACCORDING TO PLAYER AND FOOD
        c = GRAY
        box = Array.new([i,j])

        if box == @food_loc
          c = WHITE
        end

        @snakes.size.times do |n|
          if @snakes.at(n).include? box
            c = PLAYER_COLOR[n]
          end
        end

        # DRAW SQUARE
        ts = TILE_SIZE - TILE_SEPARATION
        window.draw_quad(x,y,c,x+ts,y,c,x+ts,y+ts,c,x,y+ts,c)
        y -= TILE_SIZE
      end
      x += TILE_SIZE
      y = FONT_SIZE + BUFFER + (@@h -1)*TILE_SIZE
    end
    return @winner
  end

  # INITIALIZES CLASS PARAMETERS
  def self.frame_params(_w, _h, _player_names)
    @@w = _w
    @@h = _h
    _player_names.each do |p|
      @@names.push(p)
    end
  end

end
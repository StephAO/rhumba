require 'gosu'

NAME_SEPARATION = 20
TILE_SIZE = 10

class Frame

  @@names = Array.new
  @@h = 0
  @@w = 0

  def initialize(_food_loc, _scores, _snakes)
    @food_loc = _food_loc
    @scores = _scores
    @snakes = _snakes
  end

  def draw(window, fonts)
    i = 0
    x = 0
    y = 0
    fonts.each do |f|
      _str = "#{@@names.at(i)}: #{@scores.at(i)}"
      f.draw(_str, x, y, i)
      x += f.text_width(_str) + NAME_SEPARATION
      i += 1
    end

    y += 50
    x = 0
    @@h.times do |i|
      @@w.times do |j|

      end
    end



  end

  def self.frame_params(_w, _h, _player_names)
    @@w = _w
    @@h = _h
    _player_names.each do |p|
      @@names.push(p)
    end
  end

end
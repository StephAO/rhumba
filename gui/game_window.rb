require 'gosu'

FONT_SIZE = 30
WHITE = 0xffffffff
GRAY = 0xff808080
YELLOW = 0xffffff00
GREEN = 0xff00ff00

class GameWindow < Gosu::Window



  def initialize(_width, _height, _n_players, _frames, _fullscreen=false)
    super(_width, _height, _fullscreen)

    @current_frame = 0
    @frames = _frames
    @fonts = Array.new
    _n_players.times do
      new_name = Gosu::Font.new(FONT_SIZE)
      @fonts.push(new_name)
    end
  end

  def draw
    @frames.at(@current_frame).draw(self, @fonts)
    draw_quad(0,0,WHITE, 10,0,WHITE, 10,10,WHITE, 0,10,WHITE)
  end

  def button_down(id)
    if id == Gosu::KbLeft and @current_frame > 0
      @current_frame -= 1
    end
    if id == Gosu::KbRight and @current_frame < @frames.size - 1
      @current_frame += 1
    end
  end

end
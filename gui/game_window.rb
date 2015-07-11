require 'gosu'
require_relative 'frame'

class GameWindow < Gosu::Window



  def initialize(_width, _height, _n_players, _frames, _fullscreen=false)
    super(_width, _height, _fullscreen)

    @width = _width
    @height = _height
    @current_frame = 0
    @frames = _frames
    @fonts = Array.new
    @play = false
    _n_players.times do
      new_name = Gosu::Font.new(FONT_SIZE)
      @fonts.push(new_name)
    end
    @frame_num = Gosu::Font.new(FONT_SIZE)
  end

  def update
    if @play and @current_frame < @frames.size - 1
      @current_frame += 1
    elsif button_down? Gosu::KbUp and @current_frame > 0
      @current_frame -= 1
    elsif button_down? Gosu::KbDown and @current_frame < @frames.size - 1
      @current_frame += 1
    end
  end

  def draw
    winner = @frames.at(@current_frame).draw(self, @fonts)
    _str = "Frame #{@current_frame}"
    if winner
      _str = "Winner is #{winner}"
    end
    @frame_num.draw_rel(_str, @width/2, @height - BUFFER/2, 0, 0.5, 0.5)
  end

  def button_down(id)
    if id == Gosu::KbLeft and @current_frame > 0
      @current_frame -= 1
    elsif id == Gosu::KbRight and @current_frame < @frames.size - 1
      @current_frame += 1
    elsif id == Gosu::KbP
      @play = !@play
    elsif id == Gosu::KbS
      @current_frame = 0
    elsif id == Gosu::KbE
      @current_frame =  @frames.size-1
    end
  end

end
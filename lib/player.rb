require 'behavior'
require 'walking'
require 'jumping'
require 'shooting'

class Player

  ABILITIES = [ Walking, Jumping, Shooting ]

  attr_accessor :world

  LEFT  = 1.0
  RIGHT = -1.0

  def initialize
    @w = 0.10
    @h = 0.25
    @y = -1.0
    @x = -1.0
    @direction = LEFT
    @instructions = Set.new
    @abilities = ABILITIES.map { |ab| ab.new(self) }
  end

  attr_accessor :x, :y, :direction
  attr_reader :w, :h

  def turn_left
    @direction = LEFT
  end

  def turn_right
    @direction = RIGHT
  end

  def draw

    @abilities.each do |ability|
      ability.handle_instructions(@instructions)
      ability.handle
    end
    @instructions.clear

    glColor(1.0, 0.0, 0.0)
    glBegin(GL_POLYGON)

    glVertex(x, y)
    glVertex(x, y + h)
    glVertex(x + w, y + h)
    glVertex(x + w, y)

    glEnd
  end

  def to(action)
    @instructions << action
    self
  end
  alias_method :and, :to


  def current_time
    Time.now.to_f * 100
  end

end

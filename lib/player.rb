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
    @w = 0.50
    @h = 2.00
    @y = 0.0
    @x = 0.0
    @direction = LEFT
    @instructions = Set.new
    @abilities = ABILITIES.map { |ab| ab.new(self) }
    @head_rotation = 0
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

    draw_body
    draw_head

    center_camera
  end

  def draw_body
    glColor(1.0, 0.0, 0.0)
    glBegin(GL_POLYGON)

    glVertex(x, y)
    glVertex(x, y + h)
    glVertex(x + w, y + h)
    glVertex(x + w, y)

    glEnd
  end

  def draw_head
    glColor(1.0, 1.0, 0.0)
    glTranslate(@w - 0.25 + @x,2.12 + @y,0.1)
    glRotate(head_rotation,0,0,1)
    glBegin(GL_TRIANGLES)
    glVertex(-0.25, -0.25,0)
    glVertex(-0.25, 0.25,0)
    glVertex(0.25,0,0 )
    glEnd

  end

  def head_rotation
    x = (world.mouse_x - 300.0)
    y = (world.mouse_y - 300.0) * -1
    rotation = Math.atan((y/x)).to_deg
    rotation = 180 - (rotation * -1) if x < 0
    rotation
  end

  def to(action)
    @instructions << action
    self
  end
  alias_method :and, :to

  def center_camera
    world.camera.center(@x)
  end

  def current_time
    Time.now.to_f * 100
  end

end

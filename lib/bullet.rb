class Bullet

  attr_accessor :world

  SPEED = 0.0001
  HEIGHT = 0.01
  WIDTH = 0.1

  def initialize(id, x, y, direction)
    @id = id
    @x = x
    @y = y
    @direction = direction
    puts "Bullet #{id} created"
  end

  def draw
    move_bullet

    glColor(0.0, 0.0, 0.0)
    glBegin(GL_POLYGON)
    glVertex(@x, @y)
    glVertex(@x + WIDTH, @y)
    glVertex(@x + WIDTH, @y + HEIGHT)
    glVertex(@x, @y + HEIGHT)
    glEnd
  end

  def move_bullet
    @x -= (SPEED * @direction)
  end

end

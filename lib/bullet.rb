class Bullet

  attr_accessor :world

  def initialize x, y, last_direction
    @x = x
    @y = y
    @w = 0.10
    @h = 0.01
    @bullet_speed = 0.05
    @last_direction = last_direction
  end

  def draw
    move_bullet

    glColor(0.0,0.0,0.0)
    glBegin(GL_POLYGON)
    glVertex(@x,@y)
    glVertex(@x + @w, @y)
    glVertex(@x + @w, @y + @h)
    glVertex(@x, @y + @h)
    glEnd
  end

  def move_bullet
    @x += @bullet_speed * @last_direction if @x + @w > -0.9 and @x < 0.9
  end
end

class Arrow < Behavior

  attr_accessor :world

  SPEED = 0.001

  HEIGHT = 0.01
  WIDTH = 1.0

  def initialize(id, x, y, direction)
    @id = id
    @x = x
    @y = y
    @direction = direction
    @start_y = y
    @start_time = current_time
    @initial_angle = Math::PI * 0.4
    @current_angle = @initial_angle
  end

  def draw
    return if stop_drawing?
    move_arrow

    glColor(1.0, 1.0, 1.0)
    glTranslate(@x, @y, 0)
    glRotate(current_angle, 0, 0, 1)
    glBegin(GL_POLYGON)
    glVertex(WIDTH *  0.5, HEIGHT *  0.5)
    glVertex(WIDTH *  0.5, HEIGHT * -0.5)
    glVertex(WIDTH * -0.5, HEIGHT * -0.5)
    glVertex(WIDTH * -0.5, HEIGHT *  0.5)
    glEnd
  end

  def stop_drawing?
    current_time - @start_time > 300
  end

  def move_arrow
    @x += delta_x
    @y += delta_y
  end

  def current_angle
    Math.atan(delta_y / delta_x) * 20 * Math::PI
  end

  def delta_y
    Math.sin(@initial_angle) * SPEED - (gravity * time)
  end

  def delta_x
    Math.cos(@initial_angle) * SPEED * -@direction
  end

  def time
    current_time - @start_time
  end

  def current_time
    Time.now.to_f * 100
  end

end
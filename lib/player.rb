class Player

  def initialize
    @w = 0.10
    @h = 0.25
    @y = -1.0
    @x = 0.0 - @h/2.0
  end

  def draw
    next_jump_move
    puts "DRAW"
    glColor(1.0, 0.0, 0.0)
    glBegin(GL_POLYGON)

    glVertex(@x, @y)
    glVertex(@x, @y + @h)
    glVertex(@x + @w, @y + @h)
    glVertex(@x + @w, @y)

    glEnd
  end

  INCREMENT = 0.010

  def move_left
    @x -= INCREMENT if @x > -1.0
  end

  def move_right
    @x += INCREMENT if @x < 1.0 - @w
  end

  def jump
    if @during_jump
    else
      start_jump
    end
  end

  def start_jump
    @during_jump = true
    @moving_up = true
    @start_y = @y
    @time = 0
    @initial_speed = 0.050
    @acceleration = 0.00145
  end

  def next_jump_move
    return unless @during_jump
    @y = @start_y + (@initial_speed * @time) - ((0.5)*@acceleration*(@time**2))
    if @y < @start_y
      @y = @start_y
      @during_jump = false
    end
    @time += 1
  end

end

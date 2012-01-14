class Player

  def initialize
    @w = 0.10
    @h = 0.25
    @y = -1.0
    @x = 0.0 - @h/2.0
    @last_direction = 1.0 #multiplier for bullet speed

    @bullets_left = 20
    @rate_of_fire = 20 #per refreshrate
    @last_shot = 0
    @able_to_shoot = true
  end

  def draw
    next_jump_move
    able_to_shoot_again

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
    @x -= INCREMENT
    @last_direction = -1.0
  end

  def move_right
    @x += INCREMENT
    @last_direction = 1.0
  end

  def move_viewport_left
    glTranslatef(INCREMENT,0.0,0.0)
  end

  def move_viewport_right
    glTranslatef(-1 * INCREMENT,0.0,0.0)
  end

  def jump
    unless @during_jump
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

  def able_to_shoot_again
    if @last_shot > @rate_of_fire or @last_shot == 0
      @last_shot = 0
      @able_to_shoot = true
    elsif @last_shot > 0
      puts "upping the last shot to #{@last_shot}"
      @able_to_shoot = false
      @last_shot += 1
    end
  end

  def reload
    @bullets_left = 20
  end

  def shoot world
    if @bullets_left > 0 and @able_to_shoot
      puts "bullet has been shot @ #{@x}:#{@y}"

      world.add("bullet_#{@bullets_left}".to_sym, Bullet.new(@x + @w,@y + @h*0.8, @last_direction))

      @bullets_left -= 1
      @last_shot += 1
    end
  end

end

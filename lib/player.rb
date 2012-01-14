class Player

  attr_accessor :world

  LEFT  = 1.0
  RIGHT = -1.0

  def initialize
    @w = 0.10
    @h = 0.25
    @y = -1.0
    @x = 0.0 - @h/2.0
    @direction = 1.0 #multiplier for bullet speed

    @bullets_left = 20
    @rate_of_fire = 20 #per refreshrate
    @last_shot = 0
    @able_to_shoot = true
    @initial_speed = 0.050
    @acceleration = 0.00145
    @walking_speed = 0.001

    @instructions = Set.new
  end

  def draw
    @instructions.each do |action|
      send(action)
    end

    change_y
    change_x
    able_to_shoot_again

    glColor(1.0, 0.0, 0.0)
    glBegin(GL_POLYGON)

    glVertex(@x, @y)
    glVertex(@x, @y + @h)
    glVertex(@x + @w, @y + @h)
    glVertex(@x + @w, @y)

    glEnd
    @instructions.clear
  end

  def to(action)
    @instructions << action
    self
  end
  alias_method :and, :to

  def walk
    @walking = true
    @walking_start = current_time
    @start_x = @x
  end

  def turn_left
    @direction = LEFT
  end

  def turn_right
    @direction = RIGHT
  end

  def jump
    unless @during_jump
      @during_jump = true
      @start_y = @y
      @start_time = current_time
    end
  end

  def change_x
    return unless @walking
    time = current_time - @walking_start
    @x = @x - (@walking_speed * @direction)
    if time > 10
      @walking = false
    end
  end

  def change_y
    return unless @during_jump
    time = current_time - @start_time
    @y = @start_y + (@initial_speed * time) - ((0.5)*@acceleration*(time**2))
    if @y < @start_y
      land
    end
  end

  def land
    @y = @start_y
    @during_jump = false
  end

  def current_time
    Time.now.to_f * 100
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

  def shoot
    if @bullets_left > 0 and @able_to_shoot
      puts "bullet has been shot @ #{@x}:#{@y}"

      world.add("bullet_#{@bullets_left}".to_sym, Bullet.new(@x + @w,@y + @h*0.8, @direction))

      @bullets_left -= 1
      @last_shot += 1
    end
  end

end

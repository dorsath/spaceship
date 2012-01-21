class Walking < Behavior

  SPEED = 0.001

  def handle
    if @walking
      time = current_time - @walking_start
      subject.x -= (SPEED * subject.direction)
      if time > 0.10
        @walking = false
      end
    end
  end

  def walk
    @walking = true
    @walking_start = current_time
    @start_x = subject.x
  end

  def turn_left
    subject.turn_left
  end

  def turn_right
    subject.turn_right
  end

end

class Jumping < Behavior

  attr_reader :subject

  def initialize(*)
    super
    @jump_cooldown = false
    @initial_speed = 5.0
    @acceleration = 9.8
  end

  def handle
    if @jumping
      time = current_time - @start_time
      subject.y = @start_y + (@initial_speed * time) - ((0.5) * @acceleration * (time ** 2))
      if subject.y < @start_y
        land
      end
    end
  end

  def jump
    if able_to_jump?
      @jumping = true
      @start_y = subject.y
      @start_time = current_time
    end
  end

  private

  def able_to_jump?
    !@jumping && (!@jump_cooldown || (current_time - @jump_cooldown_start) > 0.20)
  end

  def land
    subject.y = @start_y
    @jumping = false
    @jump_cooldown = true
    @jump_cooldown_start = current_time
  end

end

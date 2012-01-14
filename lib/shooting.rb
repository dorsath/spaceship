class Shooting < Behavior

  def initialize(*)
    super
    @bullets_left = 20
    @rate_of_fire = 20 #per refreshrate
    @last_shot = 0
    @able_to_shoot = true
  end

  def handle
    if @bullets_left > 0 and @able_to_shoot
      puts "bullet has been shot @ #{subject.x}:#{subject.y}"

      subject.world.add(bullet_id, new_bullet)

      @bullets_left -= 1
      @last_shot += 1
    end
  end

  def shoot
  end

  private

  def new_bullet
    Bullet.new(subject.x + subject.w, subject.y + subject.h * 0.8, subject.direction)
  end

  def bullet_id
    :"bullet_#{@bullets_left}"
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

end

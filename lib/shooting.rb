class Shooting < Behavior

  MAX_BULLETS = 100

  def initialize(*)
    super
    @bullets = MAX_BULLETS
    @last_shot = current_time
    @able_to_shoot = true
    @total_bullets_shot = 0
  end

  def handle
    if @shooting

      subject.world.add(bullet_id, new_bullet)

      @bullets -= 1
      @last_shot = current_time
      @total_bullets_shot += 1
      @shooting = false
      puts "Bullet shot. #{@bullets} bullets left."
    end
  end

  def shoot
    @shooting = true if able_to_shoot?
  end

  def reload
    @bullets = MAX_BULLETS
  end

  private

  def able_to_shoot?
    has_enough_bullets? && after_cooldown?
  end

  def has_enough_bullets?
    @bullets > 0
  end

  def after_cooldown?
    current_time - @last_shot > 20
  end

  def new_bullet
    Bullet.new(bullet_id, subject.x - subject.w, subject.y + subject.h * 0.8, subject.direction)
  end

  def bullet_id
    :"bullet_#{@total_bullets_shot}"
  end

end

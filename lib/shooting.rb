class Shooting < Behavior

  MAX_ARROWS = 100

  def initialize(*)
    super
    @arrows = MAX_ARROWS
    @last_shot = current_time
    @able_to_shoot = true
    @total_arrows_shot = 0
  end

  def handle
    if @shooting

      subject.world.add(arrow_id, new_arrow)

      @arrows -= 1
      @last_shot = current_time
      @total_arrows_shot += 1
      @shooting = false
      puts "Arrow shot. #{@arrows} arrows left."
    end
  end

  def shoot
    @shooting = true if able_to_shoot?
  end

  def reload
    @arrows = MAX_ARROWS
  end

  private

  def able_to_shoot?
    has_enough_arrows? && after_cooldown?
  end

  def has_enough_arrows?
    @arrows > 0
  end

  def after_cooldown?
    current_time - @last_shot > 20
  end

  def new_arrow
    Arrow.new(arrow_id, subject.x, subject.y + subject.h * 0.8, subject.direction)
  end

  def arrow_id
    :"arrow_#{@total_arrows_shot}"
  end

end

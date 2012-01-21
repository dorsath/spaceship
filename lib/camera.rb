require 'numeric'

class Camera

  SPEED = 0.001

  attr_accessor :world

  def initialize(angle, distance, offset_x, offset_y, offset_z)
    @angle = angle
    @distance = distance
    @offset_x = offset_x
    @offset_y = offset_y
    @offset_z = offset_z
  end

  def draw
    z = Math.cos(@angle.to_rad) * @distance * -1 + @offset_z * -1
    y = Math.sin(@angle.to_rad) * @distance * -1 + @offset_y * -1
    glRotate(@angle,1,0,0)
    glTranslate(@offset_x * -1,y,z)
  end

  def move_left
    @offset_x -= SPEED
  end

  def move_right
    @offset_x += SPEED
  end

  def move_up
    @offset_z -= SPEED
  end

  def move_down
    @offset_z += SPEED
  end

end

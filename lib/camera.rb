require 'numeric'

class Camera

  SPEED = 0.001
  TURN_SPEED = 0.1

  def initialize(angle_x, angle_y, distance, offset_x, offset_y, offset_z)
    @angle_x = angle_x
    @angle_y = angle_y
    @distance = distance
    @offset_x = offset_x
    @offset_y = offset_y
    @offset_z = offset_z
  end

  def draw
    if @follow_object
      glRotate(@follow_object.orientation[0,0].to_degrees,-1, 0, 0)
      glRotate(@follow_object.orientation[1,0].to_degrees, 0,-1, 0)
      glRotate(@follow_object.orientation[2,0].to_degrees, 0, 0,-1)

      glTranslate(0,0,-@distance)
    else
      z = Math.cos(@angle_x.to_rad) * @distance * -1 + @offset_z * -1
      y = Math.sin(@angle_x.to_rad) * @distance * -1 + @offset_y * -1
      glRotate(@angle_x,1,0,0)
      glTranslate(@offset_x * -1,y,z)
      glRotate(@angle_y,0,1,0)
    end
  end

  def distance
    @distance
  end

  def follow follow_object, distance
    @follow_object = follow_object
    @distance = distance
  end

  def turn_right
    @angle_y += TURN_SPEED
  end

  def turn_left
    @angle_y -= TURN_SPEED
  end

  def turn_up
    @angle_x += TURN_SPEED
  end

  def turn_down
    @angle_x -= TURN_SPEED
  end

  def center x
    @offset_x = x
  end

  def zoom_out
    @distance += SPEED
  end

  def zoom_in
    @distance -= SPEED
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

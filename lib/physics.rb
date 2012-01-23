Position = Struct.new(:x, :y, :z)

class Body

  attr_accessor :mass, :x_velocity, :y_velocity, :z_velocity

  def initialize(attributes = {})
    assign_attributes attributes
  end

  def assign_attributes(attributes)
    attributes.each do |key, value|
      send "#{key}=", value
    end
  end

  def push(x, y, z)
    self.x_velocity += (x.to_f / mass)
    self.y_velocity += (y.to_f / mass)
    self.z_velocity += (z.to_f / mass)
  end

  def mass
    @mass.to_f
  end

  def x_velocity
    @x_velocity.to_f
  end

  def y_velocity
    @y_velocity.to_f
  end

  def z_velocity
    @z_velocity.to_f
  end

end

class World

  GRAVITY = [ 0, 9.8, 0 ] # m/(s**2)

  def initialize(gravity, hash = {})
    @gravity = gravity
    @hash = hash
  end

  def each &block
    @hash.each &block
  end

  def add body, position
    @hash[body] = position
  end

  def over(time)
    @hash.each do |body, position|
      apply_gravity body, time
      position.x += body.x_velocity * time
      position.y += body.y_velocity * time
      position.z += body.z_velocity * time
    end
    self
  end

  def apply_gravity(body, time)
    body.push(0,  (0.5 * body.mass * (-@gravity) * time), 0)
  end

  def position_of(body)
    @hash[body]
  end

end

# F = m * a
# a = m / s ** 2
# v = m / s
#
# m == kg
# F == N

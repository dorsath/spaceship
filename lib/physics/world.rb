module Physics

  class World

    def initialize(gravity = 0.0, hash = {})
      @gravity = gravity
      @hash = hash
    end

    def each(&block)
      @hash.each &block
    end

    def add(body, position)
      @hash[body] = position
    end

    def over(time)
      each do |body, position|
        apply_gravity body, time
        position.x += body.forces[0,0] * time
        position.y += body.forces[1,0] * time
        position.z += body.forces[2,0] * time
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

end

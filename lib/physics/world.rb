module Physics

  class World

    def initialize(gravity = 0.0, hash = {})
      @gravity = gravity
      @hash = hash
      @last_time = Time.now
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
        position.x += (body.forces[0,0] * (time / body.mass) * 0.5)
        position.y += (body.forces[1,0] * (time / body.mass) * 0.5)
        position.z += (body.forces[2,0] * (time / body.mass) * 0.5)
      end
      #puts time
      self
    end

    def reposition!
      time, @last_time = Time.now - @last_time, Time.now
      over(time)
    end

    def apply_gravity(body, time)
      value = -@gravity * time * body.mass
      #p value
      body.push(0, value, 0)
    end

    def position_of(body)
      @hash[body]
    end

  end

end

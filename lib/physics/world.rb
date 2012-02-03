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

    def reposition!
      time, @last_time = Time.now - @last_time, Time.now
      over(time)
    end

    def add(body, position)
      @hash[body] = position
    end

    def over(time)
      each do |body, position|
        gravity! body unless @gravity == 0.0

        accelerations = body.accelerations.inject(Vector[0,0,0]) { |sum,(key,value)| sum + value }

        position.x += body.velocity[0,0] * time + 0.5 * accelerations[0] * time**2
        position.y += body.velocity[1,0] * time + 0.5 * accelerations[1] * time**2
        position.z += body.velocity[2,0] * time + 0.5 * accelerations[2] * time**2

        body.velocity =  M[
          [accelerations[0] * time + body.velocity[0,0]],
          [accelerations[1] * time + body.velocity[1,0]],
          [accelerations[2] * time + body.velocity[2,0]],
        ]

      end
      #puts time
      self
    end

    def gravity! body
      body.accelerations[:gravity] = Vector[0, -@gravity, 0]
    end

    def position_of(body)
      @hash[body]
    end

  end

end

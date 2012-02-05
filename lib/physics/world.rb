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

        accelerations = body.accelerations.inject(V[0,0,0]) { |sum,(key,value)| sum + value }

        position.replace(position + (body.velocity * time) + (accelerations * time * time * 0.5))

        body.velocity = accelerations * time + body.velocity

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

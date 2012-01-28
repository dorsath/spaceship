module Physics

  class World

    def initialize(gravity = 0.0, hash = {})
      @gravity = gravity
      @hash = hash
      @upcoming_collision_time = 0
      @collision = false
      @collision_objects = []

      imminent_collision?
    end

    def each(&block)
      @hash.each &block
    end

    def add(body, position)
      @hash[body] = position

      imminent_collision?
    end

    def over(time)
      collide if @upcoming_collision_time < time && @collision

      @upcoming_collision_time -= time

      each do |body, position|
        apply_gravity body, time
        position.x += body.forces[0,0] * time
        position.y += body.forces[1,0] * time
        position.z += body.forces[2,0] * time
      end
      self
    end

    def collide
      #volkomen elastische botsing
      position_of(@collision_objects[0]).z -= @collision_objects[0].forces[2,0] * @upcoming_collision_time
      position_of(@collision_objects[1]).z -= @collision_objects[1].forces[2,0] * @upcoming_collision_time

      forces_of_first_object = @collision_objects[0].forces
      @collision_objects[0].forces = @collision_objects[1].forces
      @collision_objects[1].forces = forces_of_first_object

      position_of(@collision_objects[0]).z += @collision_objects[0].forces[2,0] * @upcoming_collision_time
      position_of(@collision_objects[1]).z += @collision_objects[1].forces[2,0] * @upcoming_collision_time

      puts "upcoming time: #{@upcoming_collision_time}"

      @collision = false
    end

    def apply_gravity(body, time)
      body.push(0,  (0.5 * body.mass * (-@gravity) * time), 0)
    end

    def position_of(body)
      @hash[body]
    end

    def imminent_collision?
      puts "check collision..."
      each do |body_1, position_1|
        each do |body_2, position_2|
          next if body_1 == body_2

          next_collision_time = next_collision_between_these_objects(body_1, body_2)

          if next_collision_time # && @upcoming_collision_time > next_collision_time
            @upcoming_collision_time = next_collision_time
            @collision = true
            @collision_objects = [body_1,body_2]
          end
        end
      end
    end

    def next_collision_between_these_objects body_1, body_2
      next_time = next_collision_x(body_1, body_2)
      if next_time == next_collision_z(body_1, body_2)
        next_time
      else
        nil
      end
    end

    def next_collision_x body_1, body_2

      (position_of(body_1).x - position_of(body_2).x + body_1.radius + body_2.radius )/(body_2.forces[0,0] - body_1.forces[0,0]) #returns time
    end

    def next_collision_z body_1, body_2
      (position_of(body_1).z - position_of(body_2).z + body_1.radius + body_2.radius )/(body_2.forces[2,0] - body_1.forces[2,0]) #returns time
    end


  end

end

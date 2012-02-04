require 'matrix'
require 'mathn'
M = Matrix

module Physics
  class Body

    include Math
    attr_accessor :mass, :velocity, :accelerations, :rotation

    def initialize(attributes = {})
      default_values!
      assign_attributes attributes
    end

    def default_values!
      self.mass            = 0.0
      self.rotation        = yaw_matrix(0) * roll_matrix(0) * pitch_matrix(0)
      self.velocity        = M[ [0.0], [0.0], [0.0] ]
      self.accelerations   = {}
    end

    def assign_attributes(attributes)
      attributes.each do |key, value|
        if respond_to? "#{key}="
          send "#{key}=", value
        else
          puts "Unknown attribute: #{key.inspect} with value #{value.inspect}"
        end
      end
    end

    def push(x, y, z)
      #p forces
      adjustments = M[[x.to_f], [y.to_f], [z.to_f]]
      a = rotation * Vector[1,1,1,0]
      self.velocity += M[[a[0,0] /mass], [a[1,0] /mass], [a[2,0] /mass]]
      p velocity
    end

    def yaw
      yaw_matrix(orientation[1,0])
    end

    def roll_matrix(r)
      Matrix[
        [  cos(r), 0, sin(r), 0 ],
        [       0, 1,      0, 0 ],
        [ -sin(r), 0, cos(r), 0 ],
        [  0,      0,       0, 1 ]
      ]
    end

    def pitch
      pitch_matrix(orientation[2,0])
    end

    def yaw_matrix(r)
      Matrix[
        [  cos(r), -sin(r), 0, 0 ],
        [  sin(r),  cos(r), 0, 0 ],
        [       0,       0, 1, 0 ],
        [  0,      0,       0, 1 ]
      ]
    end

    def roll
      roll_matrix(orientation[0,0])
    end

    def pitch_matrix(r)
      Matrix[
        [  1,      0,       0, 0 ],
        [  0, cos(r), -sin(r), 0 ],
        [  0, sin(r),  cos(r), 0 ],
        [  0,      0,       0, 1 ]
      ]
    end

    # heading, azimuth, yaw
    def yaw!(r)
      self.rotation = yaw_matrix(r) * rotation
    end

    # attitude, elevation, pitch
    def pitch!(r)
      self.rotation = pitch_matrix(r) * rotation
    end

    # bank, tilt, roll
    def roll!(r)
      self.rotation = roll_matrix(r) * rotation
    end

  end
end

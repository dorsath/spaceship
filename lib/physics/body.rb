require 'matrix'
require 'mathn'
M = Matrix
V = Vector

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
      self.velocity        = V[ 0.0, 0.0, 0.0 ]
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
      adjustments = rotation * V[x.to_f, y.to_f, z.to_f, 0.0]
      self.velocity += V[*adjustments.to_a.first(3)] / mass
      self.velocity += M[[a[0,0] /mass], [ a[1,0] /mass], [a[2,0] /mass], [0]]
    end

    def roll_matrix(r)
      M[
        [  cos(r), 0, sin(r), 0 ],
        [       0, 1,      0, 0 ],
        [ -sin(r), 0, cos(r), 0 ],
        [  0,      0,      0, 1 ]
      ]
    end

    def yaw_matrix(r)
      M[
        [  cos(r), -sin(r), 0, 0 ],
        [  sin(r),  cos(r), 0, 0 ],
        [       0,       0, 1, 0 ],
        [  0,      0,       0, 1 ]
      ]
    end

    def pitch_matrix(r)
      M[
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

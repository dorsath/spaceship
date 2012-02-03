require 'matrix'
require 'mathn'
M = Matrix

module Physics
  class Body

    include Math
    attr_accessor :mass, :forces, :orientation, :velocity

    def initialize(attributes = {})
      default_values!
      assign_attributes attributes
    end

    def default_values!
      self.mass        = 0.0
      self.forces      = M[ [0.0], [0.0], [0.0] ]
      self.orientation = M[ [0.0], [0.0], [0.0] ]
      self.velocity    = M[ [0.0], [0.0], [0.0] ]
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
      a = (roll * (pitch * (yaw * adjustments)))
      self.forces += M[[a[0,0] ], [a[1,0] ], [a[2,0] ]]
      #p forces
    end

    def yaw
      yaw_matrix(orientation[1,0])
    end

    def yaw_matrix(r)
      Matrix[
        [  cos(r), 0, sin(r) ],
        [       0, 1,      0 ],
        [ -sin(r), 0, cos(r) ]
      ]
    end

    def pitch
      pitch_matrix(orientation[2,0])
    end

    def pitch_matrix(r)
      Matrix[
        [  cos(r), -sin(r), 0 ],
        [  sin(r),  cos(r), 0 ],
        [       0,       0, 1 ]
      ]
    end

    def roll
      roll_matrix(orientation[0,0])
    end

    def roll_matrix(r)
      Matrix[
        [  1,      0,       0 ],
        [  0, cos(r), -sin(r) ],
        [  0, sin(r),  cos(r) ]
      ]
    end

    # heading, azimuth, yaw
    def yaw!(r)
      # self.orientation = yaw_matrix(r) * orientation
      adjust_orientation 0, 0, r
    end

    # attitude, elevation, pitch
    def pitch!(r)
      #self.orientation = pitch_matrix(r) * orientation
      adjust_orientation r, 0, 0
      #adjust_orientation (orientation[0,0] * r), 0, 0
    end

    # bank, tilt, roll
    def roll!(r)
      #self.orientation = roll_matrix(r) * orientation
      adjust_orientation 0, r, 0
    end

    def adjust_orientation(x, y, z)
      self.orientation = M[ [orientation[0,0] + x], [orientation[1,0] + y], [orientation[2,0] + z] ]
    end

  end
end

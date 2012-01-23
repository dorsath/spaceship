module Physics

  module Degrees

    def degrees
      to_f * (Math::PI / 180.0)
    end

    def to_degrees
      to_f * (180.0 / Math::PI)
    end

  end

  Numeric.send(:include, Degrees)

end

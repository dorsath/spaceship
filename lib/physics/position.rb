module Physics
  class Position

    def self.[](*args)
      new(*args)
    end

    attr_accessor :x, :y, :z

    def initialize(x, y, z)
      @x, @y, @z = x, y, z
    end

    def values
      [ x, y, z ]
    end

  end
end

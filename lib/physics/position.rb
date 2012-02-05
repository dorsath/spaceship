require 'matrix'
module Physics
  class Position < Vector

    def replace(vector)
      Vector.Raise ErrDimensionMismatch if size != vector.size
      @elements = vector.to_a
    end

  end
end

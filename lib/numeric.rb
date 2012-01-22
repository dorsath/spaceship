class Numeric
  def to_rad()
    if self == 0
      0
    else
      2.0*Math::PI/(360/self)
    end
  end

  def to_deg()
    (self/(2.0*Math::PI))*360
  end
end

class Numeric
  def to_rad()
    2*Math::PI/(360/self)
  end

  def to_deg()
    (self/(2*Math::PI))*360
  end
end

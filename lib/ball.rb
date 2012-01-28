class Ball < Physics::Body
  def radius
    0.10
  end

  def draw
    glColor(1,0,0)
    glutSolidSphere(radius,36,36)
  end
end

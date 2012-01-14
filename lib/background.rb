class Background

  def draw
    ground
    air
  end

  def air
    glColor(0.10,0.10,1.00)
    glBegin(GL_POLYGON)
    glVertex(-1.0,-0.8)
    glVertex(-1.0, 1.0)
    glVertex( 1.0, 1.0)
    glVertex( 1.0,-0.8)
    glEnd
  end

  def ground
    glColor(0.33,0.41,0.18)
    glBegin(GL_POLYGON)
    glVertex(-1.0,-0.8)
    glVertex(-1.0,-1.0)
    glVertex( 1.0,-1.0)
    glVertex( 1.0,-0.8)
    glEnd
  end

end

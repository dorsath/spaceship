class Spaceship
  attr_accessor :world

  def draw
    draw_fuselage
  end

  def draw_fuselage

    #left side
    glBegin(GL_QUADS)
    glColor(1,0,0)
    glVertex(-1   , 0, 1.5)
    glVertex(-1   , 0, 0)
    glVertex(-0.25, 1, 0)
    glVertex(-0.25, 1, 1.5)
    glEnd

    #right_side
    glBegin(GL_QUADS)
    glVertex( 1   , 0, 1.5)
    glVertex( 1   , 0, 0)
    glVertex( 0.25, 1, 0)
    glVertex( 0.25, 1, 1.5)
    glEnd

    #roof
    glBegin(GL_QUADS)
    glColor(1,0.2,0.2)
    glVertex( 0.25, 1, 0)
    glVertex( 0.25, 1, 1.5)
    glVertex(-0.25, 1, 1.5)
    glVertex(-0.25, 1, 0)
    glEnd

    #rear
    glBegin(GL_POLYGON)
    glColor(0.2,0.2,0.2)
    glVertex( 1   , 0, 1.5)
    glVertex( 0.25, 1, 1.5)
    glVertex(-0.25, 1, 1.5)
    glVertex(-1   , 0, 1.5)
    glVertex(-1   , -0.25, 1.5)
    glVertex(-0.75, -0.5, 1.5)
    glVertex( 0.75, -0.5, 1.5)
    glVertex( 1   , -0.25, 1.5)

    glEnd
  end
end

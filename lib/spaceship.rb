require 'lib/models/cylinder'

class Spaceship < Physics::Body

  def start_engine
    self.accelerations[:engine] = Vector[0,0,-2]
  end

  def stop_engine
    self.accelerations.delete(:engine)
  end

  def accelerate
    push(0, 0, -5.0)
  end

  def brake
    push(0, 0, 5.0)
  end

  def draw
    glMultMatrix(rotation)

    draw_fuselage
    draw_wings
    draw_propulsion
  end

  def draw_propulsion
    glColor(0.1,0.1,0.1)
    glutSolidCylinder(36, 0.2, 0.3, -0.50, 0, 1.5)
    glutSolidCylinder(36, 0.2, 0.3,  0.50, 0, 1.5)
  end

  def draw_wings
    wing_span = 2
    #left

    glBegin(GL_QUADS)
    #front side
    glColor(0.25, 0.25, 0.25)
    glVertex( wing_span,    0, 1.5)
    glVertex( wing_span, -0.25, 1.5)
    glVertex(       1.0,-0.25, 0.0)
    glVertex(       1.0,    0, 0.0)

    #back side
    glColor(0.20, 0.20, 0.20)
    glVertex( wing_span,    0, 1.5)
    glVertex( wing_span,-0.25, 1.5)
    glVertex(       1.0,-0.25, 1.5)
    glVertex(       1.0,    0, 1.5)
    glEnd

    #top and bottom
    glBegin(GL_TRIANGLES)
    glColor(1, 0, 0)
    glVertex( wing_span,    0, 1.5)
    glVertex(         1,    0, 1.5)
    glVertex(         1,    0,   0)

    glColor(0.1, 0.1, 0.1)
    glVertex( wing_span,-0.25, 1.5)
    glVertex(         1,-0.25, 1.5)
    glVertex(         1,-0.25,   0)
    glEnd

    #right
    wing_span = wing_span * -1

    glBegin(GL_QUADS)
    #front side
    glColor(0.25, 0.25, 0.25)
    glVertex( wing_span,    0, 1.5)
    glVertex( wing_span, -0.25, 1.5)
    glVertex(      -1.0,-0.25, 0.0)
    glVertex(      -1.0,    0, 0.0)

    #back side
    glColor(0.20, 0.20, 0.20)
    glVertex( wing_span,    0, 1.5)
    glVertex( wing_span,-0.25, 1.5)
    glVertex(      -1.0,-0.25, 1.5)
    glVertex(      -1.0,    0, 1.5)
    glEnd

    #top and bottom
    glBegin(GL_TRIANGLES)
    glColor(1, 0, 0)
    glVertex( wing_span,    0, 1.5)
    glVertex(        -1,    0, 1.5)
    glVertex(        -1,    0,   0)

    glColor(0.1, 0.1, 0.1)
    glVertex( wing_span,-0.25, 1.5)
    glVertex(        -1,-0.25, 1.5)
    glVertex(        -1,-0.25,   0)
    glEnd

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
    glVertex(-0.50, -0.5, 1.5)
    glVertex( 0.50, -0.5, 1.5)
    glVertex( 1   , -0.25, 1.5)
    glEnd

    #front window
    #glBegin(GL_QUADS)
    #glColor(1,0.5,0.5)
    #glVertex( 0.5 , 0, -1.5)
    #glVertex(-0.5 , 0, -1.5)
    #glVertex(-0.25, 1, 0)
    #glVertex( 0.25, 1, 0)
    #glEnd

    #right window
    glBegin(GL_TRIANGLES)
    glColor(1,0.3,0.3)
    glVertex( 0.5 , 0, -1.5)
    glVertex(   1 , 0,  0)
    glVertex( 0.25, 1,  0)
    glEnd

    #left window
    glBegin(GL_TRIANGLES)
    glColor(1,0.3,0.3)
    glVertex(-0.5 , 0, -1.5)
    glVertex(  -1 , 0,  0)
    glVertex(-0.25, 1,  0)
    glEnd

    #front  side
    glBegin(GL_POLYGON)
    glColor(0.35,0.25,0.25)
    glVertex( 0.5 ,-0.25, -1.5)
    glVertex(-0.5 ,-0.25, -1.5)
    glVertex(-0.5 , 0   , -1.5)
    glVertex( 0.5 , 0   , -1.5)
    glEnd

    #left and right front side
    glBegin(GL_QUADS)
    glColor(0.35,0.25,0.25)
    glVertex(   -1,    0,    0)
    glVertex(   -1,-0.25,    0)
    glVertex(-0.50,-0.25, -1.5)
    glVertex(-0.50,    0, -1.5)

    glVertex(    1,    0,    0)
    glVertex(    1,-0.25,    0)
    glVertex( 0.50,-0.25, -1.5)
    glVertex( 0.50,    0, -1.5)
    glEnd


    #bottom rear
    glBegin(GL_QUADS)
    glColor(0.1,0.1,0.1)
    glVertex(    1, -0.25,   0)
    glVertex(    1, -0.25, 1.5)
    glVertex( 0.50, -0.50, 1.5)
    glVertex( 0.50, -0.50,   0)

    glVertex(   -1, -0.25,   0)
    glVertex(   -1, -0.25, 1.5)
    glVertex(-0.50, -0.50, 1.5)
    glVertex(-0.50, -0.50,   0)

    glVertex( 0.50, -0.50,   0)
    glVertex( 0.50, -0.50, 1.5)
    glVertex(-0.50, -0.50, 1.5)
    glVertex(-0.50, -0.50,   0)
    glEnd

    #bottom front floor
    glBegin(GL_QUADS)
    glColor(0.1,0.1,0.1)
    glVertex( 0.5, -0.50,   0)
    glVertex(-0.5, -0.50,   0)
    glVertex(-0.5, -0.25,-1.5)
    glVertex( 0.5, -0.25,-1.5)
    glEnd

    #bottom front side floor
    glBegin(GL_TRIANGLES)
    glVertex(   1, -0.25,   0)
    glVertex( 0.5, -0.50,   0)
    glVertex( 0.5, -0.25,-1.5)

    glVertex(  -1, -0.25,   0)
    glVertex(-0.5, -0.50,   0)
    glVertex(-0.5, -0.25,-1.5)
    glEnd
  end

end

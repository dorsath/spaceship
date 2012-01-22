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
    glVertex(-0.50, -0.5, 1.5)
    glVertex( 0.50, -0.5, 1.5)
    glVertex( 1   , -0.25, 1.5)
    glEnd

    #front window
    glBegin(GL_QUADS)
    glColor(1,0.5,0.5)
    glVertex( 0.5 , 0, -1.5)
    glVertex(-0.5 , 0, -1.5)
    glVertex(-0.25, 1, 0)
    glVertex( 0.25, 1, 0)
    glEnd

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

    #right side
    glBegin(GL_POLYGON)
    glColor(0.35,0.25,0.25)
    glVertex(   1 , 0   ,  1.5)
    glVertex(   1 ,-0.25,  1.5)
    glVertex(   1 ,-0.25,    0)
    glVertex( 0.5 ,-0.25, -1.5)
    glVertex( 0.5 , 0   , -1.5)
    glVertex(   1 , 0   ,    0)
    glEnd

    #front side
    glBegin(GL_POLYGON)
    glColor(0.35,0.25,0.25)
    glVertex( 0.5 ,-0.25, -1.5)
    glVertex(-0.5 ,-0.25, -1.5)
    glVertex(-0.5 , 0   , -1.5)
    glVertex( 0.5 , 0   , -1.5)
    glEnd

    #left side
    glBegin(GL_POLYGON)
    glColor(0.35,0.25,0.25)
    glVertex(  -1 , 0   ,  1.5)
    glVertex(  -1 ,-0.25,  1.5)
    glVertex(  -1 ,-0.25,    0)
    glVertex(-0.5 ,-0.25, -1.5)
    glVertex(-0.5 , 0   , -1.5)
    glVertex(  -1 , 0   ,    0)
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

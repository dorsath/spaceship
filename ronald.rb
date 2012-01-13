require 'rubygems'
require 'opengl'

include Gl,Glu,Glut

display = lambda {
  World.new
}

class Window
  include GL, Glu, Glut

  def initialize display
    glutInit
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB)
    glutInitWindowSize(500, 500)
    glutInitWindowPosition(100, 100)
    glutCreateWindow("hello")
    glClearColor(0.0, 0.0, 0.0, 0.0)

    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    glOrtho(0.0, 1.0, 0.0, 1.0, -1.0, 1.0)
    glutDisplayFunc(display)
    glutMainLoop()
  end
end

class World
  def initialize
    Square.new
  end
end

class Square
  def initialize
    draw
    @x = 0.0
  end

  def draw
    glClear(GL_COLOR_BUFFER_BIT)
    glColor(0,1,1)
    glBegin(GL_POLYGON)
    glVertex3f(0.25,  0.50,0)
    glVertex3f(0.50,  0.50,0)
    glVertex3f(0.25,  0.25,0)
    glVertex3f(0.50,  0.50,0)
    glEnd
    glutSwapBuffers
    p @x
  end
end

Window.new(display)
#glutKeyboardFunc(keyboard)



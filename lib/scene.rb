require 'lib/interface'

class Scene < Interface
  def draw
    draw_axes
  end

  def draw_axes
    glColor(1,1,1)
    glBegin(GL_LINES)
    glVertex(-2000,0,0)
    glVertex( 2000,0,0)
    glVertex(0,0, -2000)
    glVertex(0,0,  2000)
    glEnd
  end
end

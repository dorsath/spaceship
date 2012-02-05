require 'interface'
require 'models/circle'

class Scene < Interface
  def draw
    draw_axes
    draw_circles
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

  def draw_circles
    20.times do |i|
      draw_circle(i * 25, 36)
    end
  end

end

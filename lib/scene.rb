class Scene
  attr_accessor :world

  def initialize
    @height = 10
    @length = 40
    @depth = 4
  end

  def draw
    left
    floor
    background
  end

  def left
    glColor(0.5,1,0.5)
    glTranslate(-2,0,0)
    glBegin(GL_QUADS)
    glVertex(0, 0, @depth/2)
    glVertex(0, 0, @depth/-2)
    glVertex(0, @height, @depth/-2)
    glVertex(0, @height, @depth/2)
    glEnd
  end

  def floor
    glColor(0.2,1,0.2)
    glBegin(GL_QUADS)
    glVertex(0, 0, @depth/2)
    glVertex(0, 0, @depth/-2)
    glVertex(@length, 0, @depth/-2)
    glVertex(@length, 0, @depth/2)
    glEnd
  end

  def background
    glColor(0.2,0.2,1)
    glBegin(GL_QUADS)
    glVertex(0, 0, @depth/-2)
    glVertex(0, @height, @depth/-2)
    glVertex(@length, @height, @depth/-2)
    glVertex(@length, 0, @depth/-2)
    glEnd
  end
end

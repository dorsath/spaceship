def draw_circle radius, slices
  glColor(1,1,1)
  glBegin(GL_LINE_LOOP)

  slices.times do |i|
    v = 360.0/slices * i
    glVertex(Math.sin(v.degrees)*radius, 0, Math.cos(v.degrees)*radius)
  end
  glEnd
end

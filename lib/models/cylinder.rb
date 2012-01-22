def glutSolidCylinder (slices, radius, length, offset_x, offset_y, offset_z)
  glBegin(GL_QUADS)
  step_size = 360.0/slices
  length += offset_z
  slices.times do |i|

    x = Math.cos((step_size * i).to_rad) * radius + offset_x
    y = Math.sin((step_size * i).to_rad) * radius + offset_y

    x_next = Math.cos(((step_size * i) + step_size).to_rad) * radius + offset_x
    y_next = Math.sin(((step_size * i) + step_size).to_rad) * radius + offset_y


    glVertex(x, y, 0)
    glVertex(x, y, length)
    glVertex(x_next, y_next, length)
    glVertex(x_next, y_next, 0)
  end
  glEnd
end

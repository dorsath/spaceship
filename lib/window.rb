class Window

  def self.draw(&block)
    new(block).call
  end

  def initialize(block)
    @block = block
    @key_handlers = []
    @objects = {}
    @active_handlers = {}
    @keyboard = lambda { |key, x, y|
      puts "Pressed"
      @key_handlers.each do |handler|
        if key === handler[:key][0]
          @active_handlers[key] = handler[:block]
        end
      end
    }
    @key_up = Proc.new { |key, x, y|
      puts "Released"
      @active_handlers.delete(key)
    }
    @display = lambda {
      puts "Display"
      glClear(GL_COLOR_BUFFER_BIT)
      @objects.each { |name, obj| obj.draw }
      glutSwapBuffers
    }
    @timer = Proc.new {
      puts "Timer: #{@active_handler.inspect}"
      @active_handlers.each { |key, handler| handler.call }
      glutPostRedisplay
      glutTimerFunc(10, @timer, 1)
    }
  end

  def title(title)
    @title = title
  end

  def get(name)
    @objects[name]
  end

  def on(key, &block)
    @key_handlers << { :key => key, :block => block }
  end

  def on_key(&block)
    @keyboard = block
  end

  def add(name, object)
    @objects[name] = object
  end

  def width(width)
    @width = width
  end

  def height(height)
    @height = height
  end

  def left(left)
    @left = left
  end

  def top(top)
    @top = top
  end

  def call
    instance_eval &@block
    glutInit
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB)
    glutInitWindowSize(@width, @height)
    glutInitWindowPosition(@left, @top)
    glutCreateWindow(@title)
    glutKeyboardFunc(@keyboard)
    glutKeyboardUpFunc(@key_up)
    glutDisplayFunc(@display)
    glutTimerFunc(10, @timer, 1)
    glutMainLoop
  end

end

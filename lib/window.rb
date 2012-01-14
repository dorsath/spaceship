class Window

  def self.draw(&config)
    instance.configure(&config)
    instance.draw
  end

  def self.instance
    @instance ||= new
  end

  attr_reader :config, :key_handlers, :objects, :active_handlers

  def initialize
    @config = lambda {}
    @key_handlers = []
    @objects = {}
    @active_handlers = {}
  end

  def configure(&config)
    @config = config
  end

  def key_press
    @key_press ||= Proc.new do |key, x, y|
      puts "Pressed #{key.chr.inspect}"
      key_handlers.each do |handler|
        if key.chr === handler[:key]
          active_handlers[key] = handler[:block]
        end
      end
    end
  end

  def key_up
    @key_up ||= Proc.new do |key, x, y|
      puts "Released #{key.chr.inspect}"
      active_handlers.delete(key)
    end
  end

  def display
    @display ||= Proc.new do
      glClear(GL_COLOR_BUFFER_BIT)
      objects.each { |name, obj| obj.draw }
      glutSwapBuffers
    end
  end

  def timer
    @timer ||= Proc.new do
      active_handlers.each { |key, handler| handler.call }
      glutPostRedisplay
      glutTimerFunc(10, timer, 1)
    end
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

  def enter_fullscreen
    glutFullScreen
  end

  def exit_fullscreen
    glutReshapeWindow(@width, @height);
  end

  def move_viewport_left
    glTranslatef(0.01, 0.0, 0.0)
  end

  def move_viewport_right
    glTranslatef(-0.01, 0.0, 0.0)
  end

  def draw
    instance_eval &config
    glutInit
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB)
    glutInitWindowSize(@width, @height)
    glutInitWindowPosition(@left, @top)
    glutCreateWindow(@title)
    glutKeyboardFunc(key_press)
    glutKeyboardUpFunc(key_up)
    glutDisplayFunc(display)
    glutTimerFunc(10, timer, 1)
    glutMainLoop
  end

end

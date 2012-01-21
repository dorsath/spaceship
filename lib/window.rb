class Window

  def self.draw(&config)
    instance.configure(&config)
    instance.draw
  end

  def self.instance
    @instance ||= new
  end

  attr_reader :config, :key_handlers, :objects, :active_handlers, :start

  def initialize
    @start = lambda {}
    @config = lambda {}
    @key_handlers = []
    @objects = []
    @active_handlers = {}
  end

  def configure(&config)
    @config = config
  end

  def key_press
    @key_press ||= Proc.new do |key, x, y|
      #puts "Pressed #{key.chr.inspect}"
      key_handlers.each do |handler|
        if key.chr === handler[:key]
          active_handlers[key] = handler[:block]
        end
      end
    end
  end

  def key_up
    @key_up ||= Proc.new do |key, x, y|
      #puts "Released #{key.chr.inspect}"
      active_handlers.delete(key)
    end
  end

  def display
    @display ||= Proc.new do
      glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
      glLoadIdentity
      set_camera
      objects.each do |object|
        glPushMatrix
        object[:object].draw
        glPopMatrix
      end
      glutSwapBuffers
    end
  end

  def idle
    @idle ||= Proc.new do
      active_handlers.each do |key, handler|
        handler.call
      end
      glutPostRedisplay
    end
  end

  def title(title)
    @title = title
  end

  def tell(name)
    objects.find { |object| object[:name] == name }[:object]
  end

  def on(key, &block)
    key_handlers << { :key => key, :block => block }
  end

  def on_key(&block)
    @keyboard = block
  end

  def add(name, object)
    puts "Adding #{name.inspect}, which is a #{object.class.to_s.downcase}"
    objects << { :object => object, :name => name }
    object.world = self
  end

  def add_camera(object)
    @camera = object
    @camera.world = self
  end

  def camera
    @camera
  end

  def set_camera
    @camera.draw if @camera
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

  def on_start(&start)
    @start = start
  end

  def draw
    puts "Initializing configuration options"
    instance_eval &config
    puts "Creating window"
    glutInit
    glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH)
    glutInitWindowSize(@width, @height)
    glutInitWindowPosition(@left, @top)
    glutCreateWindow(@title)
    glutKeyboardFunc(key_press)
    glutKeyboardUpFunc(key_up)
    glutDisplayFunc(display)
    glutIdleFunc(idle)
    glutReshapeFunc(reshape)
    puts "Performing starting options"
    init_gl
    instance_eval &start
    puts "Entering main loop"
    glutMainLoop
  end

  def reshape
    reshape = lambda {
      glViewport(0, 0, @width, @height)
      glMatrixMode(GL_PROJECTION)
      glLoadIdentity
      gluPerspective(45 * 1, @width/@height, 0.1, 100) #aspect ratio
      glMatrixMode(GL_MODELVIEW)
    }
  end

  def init_gl
    glClearColor(0,0,0,0)
    glClearDepth(1.0)
    glDepthFunc(GL_LESS)
    glEnable(GL_DEPTH_TEST)
    glShadeModel(GL_SMOOTH)

    glMatrixMode(GL_PROJECTION)
    glLoadIdentity

    gluPerspective(45 * 1, @width/@height, 0.1, 100) #aspect ratio
    glMatrixMode(GL_MODELVIEW)
  end

end

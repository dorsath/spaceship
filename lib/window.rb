class Window

  def self.draw(&config)
    instance.configure(&config)
    instance.draw
  end

  def self.instance
    @instance ||= new
  end

  attr_reader :config, :key_handlers, :active_handlers, :start, :width, :height, :camera

  def initialize
    @start = lambda {}
    @config = lambda {}
    @key_handlers = []
    @active_handlers = {}
    @world = Physics::World.new(0)
    @interface_objects = []
    @last_time = Time.now
    @camera = Camera.new(45, 45 , 50, 0, 0, 0)
    @start_time = Time.now
  end

  def configure(&config)
    @config = config
  end

  def key_press(key, x, y)
    puts "Pressed #{key.chr.inspect}"
    key_handlers.each do |handler|
      if key.chr === handler[:key]
        active_handlers[key] = handler[:block]
      end
    end
  end

  def special_key_press(key, x, y)
    puts "Pressed: #{key}"
    key_handlers.each do |handler|
      if key == handler[:key]
        active_handlers[key] = handler[:block]
      end
    end
  end

  def special_key_up(key, x, y)
    puts "Special released #{key}"
    active_handlers.delete(key)
  end

  def key_up(key, x, y)
    puts "Released #{key.chr.inspect}"
    active_handlers.delete(key)
  end

  def mouse_coordinates(x, y)
    @mouse_x = x
    @mouse_y = y
  end

  def mouse_x
    @mouse_x ||= 1
  end

  def mouse_y
    @mouse_y ||= 1
  end

  def display
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glLoadIdentity
    camera.draw

    @world.each do |body, position|
      glPushMatrix

      #puts "position at #{Time.now - @start_time}: #{position.values.inspect}"


      glTranslate(*position.values)
      body.draw

      glPopMatrix
    end

    @interface_objects.each do |object|
      glPushMatrix
      object.draw
      glPopMatrix
    end

    glutSwapBuffers

    @world.over(Time.now - @last_time)
    @last_time = Time.now
  end

  def idle
    active_handlers.each do |key, handler|
      handler.call
    end
    if (Time.now.to_f * 1000).to_i % 10 == 0
      glutPostRedisplay
      sleep 0.005
    end
  end

  def title(title)
    @title = title
  end

  def on(key, &block)
    key_handlers << { :key => key, :block => block }
  end

  def on_key(&block)
    @keyboard = block
  end

  def add(object, position = nil)
    @world.add(object, position || default_position)
  end

  def add_interface object
    @interface_objects << object
  end

  def default_position
    Physics::Position[0,0,0]
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

    glutKeyboardFunc        method(:key_press).to_proc
    glutSpecialFunc         method(:special_key_press).to_proc
    glutSpecialUpFunc       method(:special_key_up).to_proc
    glutKeyboardUpFunc      method(:key_up).to_proc
    glutPassiveMotionFunc   method(:mouse_coordinates).to_proc
    glutDisplayFunc         method(:display).to_proc
    glutIdleFunc            method(:idle).to_proc
    glutReshapeFunc         method(:reshape).to_proc

    puts "Performing starting options"
    init_gl
    instance_eval &start
    puts "Entering main loop"
    glutMainLoop
  end

  def reshape(w, h)
    glViewport(0, 0, @width, @height)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity
    gluPerspective(45, @width/@height, 0.1, 1000) #aspect ratio
    glMatrixMode(GL_MODELVIEW)
  end

  def init_gl
    glClearColor(0,0,0,0)
    glClearDepth(1.0)
    glDepthFunc(GL_LESS)
    glEnable(GL_DEPTH_TEST)
    glShadeModel(GL_SMOOTH)

    glMatrixMode(GL_PROJECTION)
    glLoadIdentity

    gluPerspective(45, @width/@height, 0.1, 100) #aspect ratio
    glMatrixMode(GL_MODELVIEW)
  end

end

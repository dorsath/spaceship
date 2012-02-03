class Game

  def self.define(&config)
    new(config).start
  end

  attr_accessor :config, :frame, :start_time

  def initialize(config)
    @config = Configuration.new(config)
    @start_time = Time.now
    @frame = 0
  end

  def display

    keys.keys.each do |key|
      config.handlers[key].call
    end

    config.world.reposition!

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glLoadIdentity

    config.camera.draw

    config.each do |body, position|
      glPushMatrix

      #puts "Frame #{frame}: #{body} at #{Time.now - start_time}s is at #{position.values.inspect}"
      glTranslate(*position.values) if position
      body.draw

      glPopMatrix
    end

    glutSwapBuffers
  end

  def idle
  end

  def timer(value)
    glutPostRedisplay
    start_timer
  end

  def start_timer
    delay = 1000.0 / config.framerate
    glutTimerFunc(delay, method(:timer).to_proc, 3)
  end

  def key_press(key, x, y)
    keys[key.chr] ||= Time.now
  end

  def special_key_press(key, x, y)
    keys[key] ||= Time.now
  end

  def key_up(key, x, y)
    keys.delete(key.chr)
  end

  def special_key_up(key, x, y)
    keys.delete(key)
  end

  def keys
    @keys ||= Hash.new(false)
  end

  def mouse_coordinates(x, y)
  end

  # TODO change viewport according to aspec ratio
  def reshape(width, height)
    glViewport(0, 0, config.width, config.height)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity
    gluPerspective(45, config.width / config.height, 0.1, 1000) #aspect ratio
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

    gluPerspective(45, config.width/config.height, 0.1, 100) #aspect ratio
    glMatrixMode(GL_MODELVIEW)
  end

  def start
    puts "Creating window"
    glutInit
    glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH)
    glutInitWindowSize(config.width, config.height)
    glutInitWindowPosition(config.left, config.top)
    glutCreateWindow(config.title)

    glutKeyboardFunc        method(:key_press).to_proc
    glutSpecialFunc         method(:special_key_press).to_proc
    glutSpecialUpFunc       method(:special_key_up).to_proc
    glutKeyboardUpFunc      method(:key_up).to_proc
    glutPassiveMotionFunc   method(:mouse_coordinates).to_proc
    glutDisplayFunc         method(:display).to_proc
    #glutIdleFunc            method(:idle).to_proc
    glutReshapeFunc         method(:reshape).to_proc
    start_timer

    puts "Performing starting options"
    init_gl
    puts "Entering main loop"
    glutMainLoop
  end


end

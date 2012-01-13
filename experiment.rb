require 'rubygems'
require 'opengl'
require "mathn"
require 'yaml'

# y (Glut.methods - Object.methods).sort
# exit

def puts(*args)
  STDOUT.puts(*args) if true
end

Point = Struct.new(:x, :y)
Size = Struct.new(:width, :height)

class Window
  include Gl, Glu, Glut

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

class Background
  def draw
    ground
    air
  end

  def air
    glColor(0.10,0.10,1.00)
    glBegin(GL_POLYGON)
    glVertex(-1.0,-0.8)
    glVertex(-1.0, 1.0)
    glVertex( 1.0, 1.0)
    glVertex( 1.0,-0.8)
    glEnd
  end

  def ground
    glColor(0.33,0.41,0.18)
    glBegin(GL_POLYGON)
    glVertex(-1.0,-0.8)
    glVertex(-1.0,-1.0)
    glVertex( 1.0,-1.0)
    glVertex( 1.0,-0.8)
    glEnd
  end

end

class Player

  def initialize
    @w = 0.10
    @h = 0.25
    @y = -1.0
    @x = 0.0 - @h/2.0
    @bullets_left = 20
  end

  def draw
    next_jump_move
    puts "DRAW"
    glColor(1.0, 0.0, 0.0)
    glBegin(GL_POLYGON)

    glVertex(@x, @y)
    glVertex(@x, @y + @h)
    glVertex(@x + @w, @y + @h)
    glVertex(@x + @w, @y)

    glEnd
  end

  INCREMENT = 0.010

  def move_left
    @x -= INCREMENT if @x > -1.0
  end

  def move_right
    @x += INCREMENT if @x < 1.0 - @w
  end

  def jump
    unless @during_jump
      start_jump
    end
  end

  def start_jump
    @during_jump = true
    @moving_up = true
    @start_y = @y
    @time = 0
    @initial_speed = 0.050
    @acceleration = 0.00145
  end

  def next_jump_move
    return unless @during_jump
    @y = @start_y + (@initial_speed * @time) - ((0.5)*@acceleration*(@time**2))
    if @y < @start_y
      @y = @start_y
      @during_jump = false
    end
    @time += 1
  end

  def reload
    @bullets_left = 20
  end

  def shoot world
    if @bullets_left > 0
      world.add("bullet_#{@bullets_left}".to_sym, Bullet.new(@x + @w,@y + @h*0.8))
      @bullets_left -= 1
    end
  end
end

class Bullet
  def initialize x, y
    @x = x
    @y = y
    @w = 0.10
    @h = 0.01
    @bullet_speed = 0.05
  end

  def draw
    puts "bullet has been shot @ #{@x}:#{@y}"
    move_bullet

    glColor(0.0,0.0,0.0)
    glBegin(GL_POLYGON)
    glVertex(@x,@y)
    glVertex(@x + @w, @y)
    glVertex(@x + @w, @y + @h)
    glVertex(@x, @y + @h)
    glEnd
  end

  def move_bullet
    @x += @bullet_speed if @x < 1
  end
end

Window.draw do

  title "Iain"

  width 600
  height 600

  left 10
  top 10

  add :background, Background.new
  add :player, Player.new

  on "a" do
    puts "A"
    get(:player).move_left
  end

  on "d" do
    puts "D"
    get(:player).move_right
  end

  on "w" do
    get(:player).jump
  end

  on " " do
    get(:player).shoot(self)
  end

  on "r" do
    get(:player).reload
  end

end

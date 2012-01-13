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
    @active_handler = nil
    @keyboard = lambda { |key, x, y|
      puts "Pressed"
      @key_handlers.each do |handler|
        if key === handler[:key][0]
          @active_handler = handler[:block]
        end
      end
    }
    @key_up = Proc.new { |key, x, y|
      puts "Released"
      @active_handler = nil
    }
    @display = lambda {
      puts "Display"
      @objects.each { |name, obj| obj.draw }
    }
    @timer = Proc.new {
      puts "Timer: #{@active_handler.inspect}"
      @active_handler && @active_handler.call
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

class Player

  def initialize
    @x = 0.25
    @y = -0.9
    @w = 0.25
    @h = 0.25
  end

  def draw
    next_jump_move
    puts "DRAW"
    glClear(GL_COLOR_BUFFER_BIT)
    glColor(1.0, 1.0, 1.0)
    glBegin(GL_POLYGON)

    glVertex(@x, @y)
    glVertex(@x, @y + @h)
    glVertex(@x + @w, @y + @h)
    glVertex(@x + @w, @y)

    glEnd
    glutSwapBuffers
  end

  INCREMENT = 0.05

  def move_left
    @x -= INCREMENT
  end

  def move_right
    @x += INCREMENT
  end

  def jump
    if @during_jump
    else
      start_jump
    end
  end

  def start_jump
    @during_jump = true
    @moving_up = true
    @start_y = @y
  end

  def next_jump_move
    return unless @during_jump
    if @moving_up
      if @y < (@start_y + 1.0)
        @y += INCREMENT
      else
        @moving_up = false
      end
    else # moving_down
      if @y > @start_y
        @y -= INCREMENT
      else
        @during_jump = false
      end
    end
  end

end

Window.draw do

  title "Iain"

  width 600
  height 600

  left 10
  top 10

  add :player, Player.new

  on "a" do
    puts "A"
    get(:player).move_left
  end

  on "d" do
    puts "D"
    get(:player).move_right
  end

  on " " do
    get(:player).jump
  end

end

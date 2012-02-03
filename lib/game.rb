require 'set'
require 'window2'
require 'config'
require 'physics'
require 'camera'
require 'spaceship'
require 'scene'

$spaceship = Spaceship.new(:mass => 200)

TURN_SPEED = 0.1.degrees

Game.define do

  self.title  = "Space wars"

  add $spaceship
  add_non_interactive Scene.new

  on GLUT_KEY_UP do
    puts "Accel"
    $spaceship.accelerate
  end

  on GLUT_KEY_DOWN do
    puts "BRAKE"
    $spaceship.brake
  end

  on "w" do
    $spaceship.pitch! TURN_SPEED
  end

  on "s" do
    $spaceship.pitch! -TURN_SPEED
  end

  on "a" do
    $spaceship.yaw! TURN_SPEED
  end

  on "d" do
    $spaceship.yaw! -TURN_SPEED
  end

  on "e" do
    $spaceship.roll! TURN_SPEED
  end

  on "n" do
    $spaceship.start_engine
  end

  on "m" do
    $spaceship.stop_engine
  end

  on "h" do
    camera.turn_left
  end

  on "l" do
    camera.turn_right
  end

  on "k" do
    camera.turn_up
  end

  on "j" do
    camera.turn_down
  end

  on "-" do
    camera.zoom_out
  end

  on "=" do
    camera.zoom_in
  end

  on "f" do
    enter_fullscreen
  end

  on "F" do
    exit_fullscreen
  end

  on "q" do
    exit
  end

end

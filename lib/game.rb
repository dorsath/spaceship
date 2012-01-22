require 'set'
require 'window'
require 'physics'
require 'camera'
require 'spaceship'

$spaceship = Spaceship.new(10, 0, 0, 0)

Window.draw do

  title "Space wars"

  width 770
  height 450

  left 10
  top 10

  add_camera Camera.new( 45, 0 , 10, 0, 0, 0)
  add $spaceship, Position[0, 0, 0]

  on "w" do
    $spaceship.accelerate
  end

  on "s" do
    $spaceship.brake
  end

  on "a" do
    $spaceship.tilt_left
  end

  on "d" do
    $spaceship.tilt_right
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

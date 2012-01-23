require 'set'
require 'window'
require 'physics'
require 'camera'
require 'spaceship'

$spaceship = Spaceship.new(:mass => 10)
$spaceship.yaw! 90.degrees

Window.draw do

  title "Space wars"

  width 770
  height 450

  left 10
  top 10

  add $spaceship

  on GLUT_KEY_UP do
    $spaceship.accelerate
  end

  on GLUT_KEY_DOWN do
    $spaceship.brake
  end

  on "w" do
    $spaceship.pitch! 0.5.degrees
  end

  on "s" do
    $spaceship.pitch! -0.5.degrees
  end

  on "a" do
    $spaceship.yaw! 0.5.degrees
  end

  on "d" do
    $spaceship.yaw! -0.5.degrees
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

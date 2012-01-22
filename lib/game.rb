require 'set'
require 'window'
require 'camera'
require 'spaceship'

Window.draw do

  title "Space wars"

  width 1440
  height 900

  left 10
  top 10

  add_camera Camera.new( 45, 45 , 10, 0, 0, 0)
  add :spaceship, Spaceship.new

  on "a" do
    camera.turn_left
  end

  on "d" do
    camera.turn_right
  end

  on "w" do
    camera.turn_up
  end

  on "s" do
    camera.turn_down
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

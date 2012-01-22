require 'set'
require 'window'
require 'body'
require 'camera'
require 'spaceship'

Window.draw do

  title "Space wars"

  width 900
  height 900

  left 10
  top 10

  add_camera Camera.new( 45, 0 , 10, 0, 0, 0)
  add :spaceship, Spaceship.new

  on "w" do
    tell(:spaceship).to(:accelerate)
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

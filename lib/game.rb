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

  add_camera Camera.new(45, 140, 10, 0, 3, 0)
  add :spaceship, Spaceship.new

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

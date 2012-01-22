require 'set'
require 'window'
require 'camera'

Window.draw do

  title "Space wars"

  width 1440
  height 900

  left 10
  top 10

  add_camera Camera.new(10, 10, 0, 3, 0)

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

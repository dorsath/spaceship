require 'set'
require 'window'
require 'camera'
require 'scene'
require 'player'
require 'arrow'

Window.draw do

  title "OpenGL in Ruby"

  width 600
  height 600

  left 10
  top 10

  add_camera Camera.new(10, 10, 0, 3, 0)

  add :player, Player.new
  add :scene, Scene.new

  on "a" do
    tell(:player).to(:turn_left).and(:walk)
  end

  on "d" do
    tell(:player).to(:turn_right).and(:walk)
  end

  on "w" do
    tell(:player).to(:jump)
  end

  on " " do
    tell(:player).to(:shoot)
  end

  on "r" do
    tell(:player).to(:reload)
  end

  on "-" do
    camera.zoom_out
  end

  on "+" do
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

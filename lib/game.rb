require 'set'
require 'window'
require 'background'
require 'player'
require 'bullet'

Window.draw do

  title "OpenGL in Ruby"

  width 600
  height 600

  left 10
  top 10

  add :background, Background.new(1.5)
  add :player, Player.new

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

  on "h" do
    move_viewport_left
  end

  on "l" do
    move_viewport_right
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

  on_start do
    enter_fullscreen
  end

end

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

  add :background, Background.new
  add :player, Player.new

  on "a" do
    puts "A"
    get(:player).move_left
  end

  on "d" do
    puts "D"
    get(:player).move_right
  end

  on "w" do
    get(:player).jump
  end

  on " " do
    get(:player).shoot(self)
  end

  on "r" do
    get(:player).reload
  end

end

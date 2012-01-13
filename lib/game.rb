require 'window'
require 'background'
require 'player'

Window.draw do

  title "Iain"

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

  on " " do
    get(:player).jump
  end

end

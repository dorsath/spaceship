require 'set'
require 'window'
require 'physics'
require 'camera'
require 'ball'

$white_ball = Ball.new(:mass => 0.5,  :forces => M[[2],[0], [2]])

Window.draw do

  title "Space wars"

  width 770
  height 450

  left 10
  top 10

  add $white_ball
  add Ball.new(:mass => 0.5, :forces => M[[0],[0], [0]]), Physics::Position.new(3,0,3)

  camera.set(90,  0, 10, 0, 0, 2)

  on " " do
    $white_ball.push(0,0,0.1)
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

class Configuration

  attr_accessor :title,
    :width,
    :height,
    :left,
    :top,
    :field_of_view,
    :framerate,
    :gravity

  def initialize(config)
    set_default_values
    instance_eval &config
  end

  def set_default_values
    @title = "Game"
    @width = 770
    @height = 450
    @left = 10
    @top = 10
    @field_of_view = 1000
    @framerate = 30
    @gravity = 0.0
  end

  def on(key, &handler)
    handlers[key] = handler
  end

  def camera
    @camera ||= Camera.new(34, 45 , 50, 0, 0, 0)
  end


  def enter_fullscreen
    glutFullScreen
  end

  def exit_fullscreen
    glutReshapeWindow(@width, @height);
  end

  def handlers
    @handlers ||= Hash.new { |h,k| Proc.new {} }
  end

  def add(object, position = nil)
    world.add(object, position || default_position)
  end

  def default_position
    @default_position ||= Physics::Position[0,0,0]
  end

  def world
    @world ||= Physics::World.new(gravity)
  end

  def each
    world.each do |body, position|
      yield body, position
    end
    non_interactives.each do |object|
      yield object, nil
    end
  end

  def add_non_interactive(object)
    non_interactives << object
  end

  def non_interactives
    @non_interactives ||= []
  end

end

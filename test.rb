require 'rubygems'
require 'sdl'
# Here are several ways you can use SDL.inited_system

# Get init data on all the subsystem
subsystem_init = SDL.inited_system(SDL::INIT_EVERYTHING)

if subsystem_init & SDL::INIT_VIDEO
  puts "video is initialized"
else
  puts "video is not initialized"
end

# Just check for one specfic subsystem

if SDL.inited_system(SDL::INIT_VIDEO) != 0
  puts "Video is initialized"
else
  puts "Video is not initialized        "
end

# Check for two subsystem

subsystem_mask = SDL::INIT_VIDEO|SDL::INIT_AUDIO;

if SDL.inited_system(subsystem_mask) == subsystem_mask
  puts "Video and Audio initialized."
else
  puts "Video and Audio not initialized"
end

class WelcomeController < ApplicationController

  def index
    @maze = Maze.new
    @maze.construct
  end
end

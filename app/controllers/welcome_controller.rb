class WelcomeController < ApplicationController
  def index
    @maze = Maze.new
    @maze.construct_and_solve
  end
end

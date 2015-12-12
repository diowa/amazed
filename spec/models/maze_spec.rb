require "spec_helper"

describe Maze do
  let(:maze) { Maze.new(4, 5) }

  describe ".initialize" do
    it "sets height and width" do
      expect(maze.width).to be 4
      expect(maze.height).to be 5
    end

    it "sets a grid" do
      expect(maze.instance_variable_get(:@grid)).to eq Array.new(5) { Array.new(4, false) }
    end
  end

  describe "#construct_and_solve" do
    context "with correct initial and final points" do
      it "sets initial_x, initial_y, final_x, final_y" do
        maze.construct_and_solve(0, 0, 3, 3)
        expect(maze.initial_x).to be 0
        expect(maze.initial_y).to be 0
        expect(maze.final_x).to be 3
        expect(maze.final_y).to be 3
      end

      it "stores starting point in solution_steps" do
        expect(maze).to receive(:carve_passages_from).with(3, 1)
        maze.construct_and_solve(3, 1, 3, 4)
        expect(maze.solution_steps).to include [3, 1]
      end

      it "sets carving_steps" do
        expect(maze).to receive(:carve_passages_from).with(3, 1)
        maze.construct_and_solve(3, 1, 3, 4)
        expect(maze.carving_steps).to eq []
      end

      it "returns true" do
        expect(maze.construct_and_solve(3, 1, 3, 4)).to be true
      end

      it "sets 38 carving_steps ((height * with) - 1) * 2" do
        maze.construct_and_solve(3, 1, 3, 4)
        expect(maze.carving_steps.count).to be 38
      end

      it "sets many solution_steps" do
        maze.construct_and_solve(3, 1, 3, 4)
        expect(maze.solution_steps).to be_many
      end

      it "visits all the points in the maze" do
        maze.construct_and_solve(3, 1, 3, 4)
        expect(maze.instance_variable_get(:@grid)).to eq Array.new(5) { Array.new(4, true) }
      end
    end

    context "with incorrect initial and final points" do
      it "returns false" do
        expect(maze.construct_and_solve(3, 1, 99, 99)).to be false
      end
    end
  end
end

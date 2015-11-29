require 'spec_helper'

describe Maze do
  context "initialize" do
    it "sets height, width, a grid and a sequence" do
      maze = Maze.new(4, 5)
      expect(maze.width).to be 4
      expect(maze.height).to be 5
      expect(maze.instance_variable_get(:@grid)).to eq Array.new(5) { Array.new(4, false) }
      expect(maze.sequence).to eq []
    end
  end

  context "construct" do
    it "marks as visited the starting point and than start carving" do
      maze = Maze.new(4, 4)
      expect(maze).to receive(:carve_passages_from).with(3, 1)
      maze.construct(3, 1)
      expect(maze.instance_variable_get(:@grid)[1][3]).to eq true
      expect(maze.instance_variable_get(:@grid)[0][0]).to eq false
    end
  end

  context "private methods" do
    context "carve_passages_from" do
      it "calls itself recursively" do
        maze = Maze.new(4, 4)
        expect(maze).to receive(:carve_passages_from).with(3, 1)
        maze.send(:carve_passages_from, 3, 1)
      end

      it "performs with no errors" do
        maze = Maze.new(4, 4)
        maze.send(:carve_passages_from, 3, 1)
      end
    end

    context "inside_grid?" do
      context "point inside" do
        it "returns true" do
          maze = Maze.new(4, 4)
          expect(maze.send(:inside_grid?, 2, 3)).to eq true
        end
      end

      context "point outside" do
        it "returns false" do
          maze = Maze.new(4, 4)
          expect(maze.send(:inside_grid?, -1, 4)).to eq false
        end
      end
    end

    context "not_visited?" do
      context "point not visited" do
        it "returns true" do
          maze = Maze.new(4, 4)
          expect(maze.send(:not_visited?, 1, 3)).to eq true
        end
      end

      context "point visited" do
        it "returns false" do
          maze = Maze.new(4, 4)
          maze.send(:mark_visited, 1, 3)
          expect(maze.send(:not_visited?, 1, 3)).to eq false
        end
      end
    end

    context "mark_visited" do
      it "marks a point visited" do
        maze = Maze.new(4, 4)
        maze.send(:mark_visited, 1, 3)
        expect(maze.instance_variable_get(:@grid)[3][1]).to eq true
        expect(maze.instance_variable_get(:@grid)[0][0]).to eq false
      end
    end

    context "next_position" do
      it "returns next position from current position and direction" do
        maze = Maze.new(4, 4)
        expect(maze.send(:next_position, 1, 3, :U)).to eq [1, 2]
      end
    end
  end
end

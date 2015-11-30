require 'spec_helper'

describe Maze do
  context "initialize" do
    it "sets height, width, a grid, sequence and solution" do
      maze = Maze.new(4, 5)
      expect(maze.width).to be 4
      expect(maze.height).to be 5
      expect(maze.instance_variable_get(:@grid)).to eq Array.new(5) { Array.new(4, false) }
      expect(maze.sequence).to eq []
      expect(maze.solution).to eq []
    end
  end

  context "construct_and_solve" do
    it "sets initial_x, initial_y, final_x, final_y and solution_found" do
      maze = Maze.new(5, 5)
      expect(maze).to receive(:carve_passages_from).with(0, 0)
      maze.construct_and_solve(0, 0, 4, 4)
      expect(maze.initial_x).to be 0
      expect(maze.initial_y).to be 0
      expect(maze.final_x).to be 4
      expect(maze.final_y).to be 4
      expect(maze.instance_variable_get(:@solution_found)).to be false
    end

    it "marks visited the starting point and stores it in the solution, than starts carving" do
      maze = Maze.new(4, 4)
      expect(maze).to receive(:carve_passages_from).with(3, 1)
      maze.construct_and_solve(3, 1)
      expect(maze.send(:point_not_visited?, 3, 1)).to eq false
      expect(maze.solution).to include [3,1]
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

    context "point_inside_grid?" do
      context "point inside" do
        it "returns true" do
          maze = Maze.new(4, 4)
          expect(maze.send(:point_inside_grid?, 2, 3)).to eq true
        end
      end

      context "point outside" do
        it "returns false" do
          maze = Maze.new(4, 4)
          expect(maze.send(:point_inside_grid?, -1, 4)).to eq false
        end
      end
    end

    context "point_not_visited?" do
      context "point not visited" do
        it "returns true" do
          maze = Maze.new(4, 4)
          expect(maze.send(:point_not_visited?, 1, 3)).to eq true
        end
      end

      context "point visited" do
        it "returns false" do
          maze = Maze.new(4, 4)
          maze.send(:mark_point_visited, 1, 3)
          expect(maze.send(:point_not_visited?, 1, 3)).to eq false
        end
      end
    end

    context "ending_point?" do
      context "is ending point" do
        it "returns true" do
          maze = Maze.new(4, 4)
          maze.construct_and_solve(0, 0, 3, 3)
          expect(maze.send(:ending_point?, 3, 3)).to eq true
        end
      end

      context "is not ending point" do
        it "returns false" do
          maze = Maze.new(4, 4)
          maze.construct_and_solve(0, 0, 3, 3)
          expect(maze.send(:ending_point?, 2, 1)).to eq false
        end
      end
    end

    context "mark_point_visited" do
      it "marks a point visited" do
        maze = Maze.new(4, 4)
        maze.send(:mark_point_visited, 1, 3)
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

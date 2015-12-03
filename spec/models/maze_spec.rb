require "spec_helper"

describe Maze do
  let(:maze) { Maze.new(4, 5) }

  describe ".initialize" do
    it "sets height, width, a grid, carving_steps and solution_steps" do
      expect(maze.width).to be 4
      expect(maze.height).to be 5
      expect(maze.instance_variable_get(:@grid)).to eq Array.new(5) { Array.new(4, false) }
      expect(maze.carving_steps).to eq []
      expect(maze.solution_steps).to eq []
    end
  end

  describe "#construct_and_solve" do
    it "sets initial_x, initial_y, final_x, final_y and solution_found" do
      expect(maze).to receive(:carve_passages_from).with(0, 0)
      maze.construct_and_solve(0, 0, 3, 3)
      expect(maze.initial_x).to be 0
      expect(maze.initial_y).to be 0
      expect(maze.final_x).to be 3
      expect(maze.final_y).to be 3
      expect(maze.instance_variable_get(:@solution_found)).to be false
    end

    context "with correct initial and final points" do
      it "marks visited the starting point and stores it in solution_steps, than starts carving" do
        expect(maze).to receive(:carve_passages_from).with(3, 1)
        maze.construct_and_solve(3, 1, 3, 4)
        expect(maze.send(:point_not_visited?, 3, 1)).to eq false
        expect(maze.solution_steps).to include [3,1]
        expect(maze.instance_variable_get(:@grid)[1][3]).to eq true
        expect(maze.instance_variable_get(:@grid)[0][0]).to eq false
      end

      it "finds a solution" do
        maze.construct_and_solve(3, 1, 3, 4)
        expect(maze.instance_variable_get(:@solution_found)).to be true
      end

      it "returns true" do
        expect(maze.construct_and_solve(3, 1, 3, 4)).to be true
      end

      it "sets many carving_steps" do
        maze.construct_and_solve(3, 1, 3, 4)
        expect(maze.carving_steps).to be_many
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

  describe "#carve_passages_from" do
    it "calls itself recursively" do
      expect(maze).to receive(:carve_passages_from).with(3, 1)
      maze.send(:carve_passages_from, 3, 1)
    end

    it "performs with no errors" do
      expect { maze.send(:carve_passages_from, 3, 1) }.to_not raise_error
    end
  end

  describe "#point_inside_grid?" do
    context "with point inside" do
      it "returns true" do
        expect(maze.send(:point_inside_grid?, 2, 3)).to eq true
      end
    end

    context "with point outside" do
      it "returns false" do
        expect(maze.send(:point_inside_grid?, -1, 4)).to eq false
      end
    end
  end

  describe "#point_not_visited?" do
    context "with point not visited" do
      it "returns true" do
        expect(maze.send(:point_not_visited?, 1, 3)).to eq true
      end
    end

    context "with point visited" do
      it "returns false" do
        maze.send(:mark_point_visited, 1, 3)
        expect(maze.instance_variable_get(:@grid)[3][1]).to eq true
      end
    end
  end

  describe "#ending_point?" do
    context "when ending point" do
      it "returns true" do
        maze.construct_and_solve(0, 0, 3, 3)
        expect(maze.send(:ending_point?, 3, 3)).to eq true
      end
    end

    context "when not ending point" do
      it "returns false" do
        maze.construct_and_solve(0, 0, 3, 3)
        expect(maze.send(:ending_point?, 2, 1)).to eq false
      end
    end
  end

  describe "#mark_point_visited" do
    it "marks a point visited" do
      maze.send(:mark_point_visited, 1, 3)
      expect(maze.instance_variable_get(:@grid)[3][1]).to eq true
      expect(maze.instance_variable_get(:@grid)[0][0]).to eq false
    end
  end

  describe "#next_position" do
    context "with 1,3,:U" do
      it "returns [1,2]" do
        expect(maze.send(:next_position, 1, 3, :U)).to eq [1, 2]
      end
    end
  end
end

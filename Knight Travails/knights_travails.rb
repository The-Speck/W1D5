require_relative "polytree.rb"
require "byebug"

class KnightPathFinder
  attr_accessor :visited_pos
  attr_reader :start

  def self.valid_moves(pos)
    row, col = pos
    arr = []

    arr << [row + 2, col + 1] if within_range?(row + 2, col + 1)
    arr << [row + 2, col - 1] if within_range?(row + 2, col - 1)

    arr << [row + 1, col + 2] if within_range?(row + 1, col + 2)
    arr << [row + 1, col - 2] if within_range?(row + 1, col - 2)

    arr << [row - 2, col - 1] if within_range?(row - 2, col - 1)
    arr << [row - 2, col + 1] if within_range?(row - 2, col + 1)

    arr << [row - 1, col - 2] if within_range?(row - 1, col - 2)
    arr << [row - 1, col + 2] if within_range?(row - 1, col + 2)

    arr
  end

  def self.within_range?(row, col)
    return false if row < 0 || row > 7
    return false if col < 0 || col > 7
    true
  end


  def already_visited?(pos)
    visited_pos.include?(pos)
  end

  def initialize(start)
    @visited_pos = [start]
    @start = start
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos)
    new_moves = moves.reject {|move| already_visited?(move)}
    @visited_pos += new_moves
    new_moves
  end

  def build_move_tree
    root = PolyTreeNode.new(start)
    queue = [root]

    until queue.empty?
      current_move = queue.shift
      new_moves = new_move_positions(current_move.value)

      new_moves.each do |new_move|
        child = PolyTreeNode.new(new_move)
        current_move.add_child(child)
        queue << child unless child.nil?
      end
    end

     @root = root
  end

  def find_path(end_pos)
    build_move_tree
    position = @root.bfs(end_pos)
    @visited_pos = [start]
    trace_back(position)
  end

  def trace_back(pos)
    trace = []
    until pos == @root
      trace << pos.value
      pos = pos.parent
    end
    trace << @root.value
    trace.reverse
  end
end

kpf = KnightPathFinder.new([7, 7])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]

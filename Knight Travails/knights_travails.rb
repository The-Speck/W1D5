require_relative "polytree.rb"
require "byebug"

class KnightPathFinder
  attr_accessor :visited_pos

  def self.valid_moves(pos)
    valid_arr = []
    val = [1,2]

    2.times do |idx|
      x, y = val
      2.times do
        row = pos[0]+x
        col = pos[1]+y
        valid_arr << [row, col] if within_range?(row, col)
        pos = pos.rotate
      end

      2.times do
        row = pos[0]-x
        col = pos[1]-y
        valid_arr << [row, col] if within_range?(row, col)
        pos = pos.rotate
      end
      val = val.rotate
    end

    valid_arr.uniq
  end

  def self.within_range?(row, col)
    return false if row < 0 || row > 7
    return false if col < 0 || col > 7
    true
  end

  # def valid_travel?(pos)
  #   row, col = pos
  #   curr_row, curr_col = visited_pos.last
  #   (curr_row - row).abs + (curr_col - col).abs == 3
  # end

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

  end

  def find_path

  end
end

# frozen_string_literal: true

class Board
  attr_reader :b

  GAMEPIECE_CONFIG = %w[JR JR SR ST ST SR JR JR].freeze
  BOARD_SIZE = 8
  def initialize
    puts 'Game starts now'.green
    @b = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, '-') }
    @b[0] = @b[0].map.with_index { |_cell, i| GamePiece.new('R', GAMEPIECE_CONFIG[i]) }
    @b[7] = @b[7].map.with_index { |_cell, i| GamePiece.new('B', GAMEPIECE_CONFIG[i]) }
  end

  def print
    @b.each do |row|
      print_line = row.inject('') { |acc, el| acc + (el.is_a?(GamePiece) ? "#{el.print_piece} " : ' -  ') }
      puts print_line.yellow
    end
  end

  def remove(row, col)
    return 'Error' unless @b[row][col].is_a?(GamePiece)

    gp = @b[row][col]
    @b[row][col] = '-'
    gp
  end

  def place(gamepiece, row, col)
    @b[row][col] = gamepiece
  end
end

class GamePiece
  attr_reader :color

  def initialize(color, rank)
    @color = color
    @rank = rank
  end

  def print_piece
    "#{@color}#{@rank}"
  end
end

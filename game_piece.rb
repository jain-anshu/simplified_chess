class GamePiece
  attr_reader :color

  def initialize(color, rank)
    @color = color
    @rank = rank
  end

  def print_piece
    "#{@color}#{@rank}"
  end

  def priority
    return 2 if @rank == 'ST'
      
    return 1 if @rank == 'SR'
      
    return 0  
  end
end

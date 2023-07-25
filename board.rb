class Board
  attr_reader :b

  def initialize
    puts 'Game starts now'.green
    @b = Array.new(8) { Array.new(8, '-') }
    @b[0][0] = GamePiece.new('R', 'JR')
    @b[0][1] = GamePiece.new('R', 'JR')
    @b[0][2] = GamePiece.new('R', 'SR')
    @b[0][3] = GamePiece.new('R', 'ST')
    @b[0][4] = GamePiece.new('R', 'ST')
    @b[0][5] = GamePiece.new('R', 'SR')
    @b[0][6] = GamePiece.new('R', 'JR')
    @b[0][7] = GamePiece.new('R', 'JR')

    @b[7][0] = GamePiece.new('B', 'JR')
    @b[7][1] = GamePiece.new('B', 'JR')
    @b[7][2] = GamePiece.new('B', 'SR')
    @b[7][3] = GamePiece.new('B', 'ST')
    @b[7][4] = GamePiece.new('B', 'ST')
    @b[7][5] = GamePiece.new('B', 'SR')
    @b[7][6] = GamePiece.new('B', 'JR')
    @b[7][7] = GamePiece.new('B', 'JR')
  end

  def print
    @b.each do |row|
      print_line = ''
      row.each do |el|
        print_line += if el.is_a?(GamePiece)
                        el.print_piece + ' '
                      else
                        ' -  '
                      end
      end
      puts print_line.yellow
    end
  end

  def remove(x, y)
    return 'Error' unless @b[x][y].is_a?(GamePiece)

    gp = @b[x][y]
    @b[x][y] = '-'
    gp
  end

  def place(gamepiece, x, y)
    puts 'HEre'.blue
    @b[x][y] = gamepiece
  end
end

require './game_piece.rb'
require './player.rb'
require 'colorize'
# Imporve initalization in board
# change @b to @board


class Board  
  attr_reader :b  
  def initialize
    puts "Game starts now".green
    @b = Array.new(8){ Array.new(8, '-')}
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
      print_line = ""  
      row.each do |el|
        if el.is_a?(GamePiece)
            print_line += el.print_piece() + " "
        else
            print_line += ' -  '    
        end 
      end
      puts print_line.yellow
    end
  end
  def remove(x,y)
    return "Error" unless @b[x][y].is_a?(GamePiece)
    gp = @b[x][y]
    @b[x][y] = '-'
    gp
  end
  def place(gamepiece, x,y)
    puts "HEre".blue
    @b[x][y] = gamepiece
  end
end    

class Game
  attr_reader :board   
  def initialize(board: Board.new, players: Array.new(2){Player.new} )
    @board = board
    @players = players
    @pieces_count = [8, 8]
    @players[0].color = 'R'
    @players[1].color = 'B'
    @player_playing = 0
    @other_player = 1
    @invalid_move = false
    show
    play
  end
  
  def has_won?(player_id)
    @pieces_count[@other_player] == 0
  end
  def kill(i, j)
    if @board.b[i][j].color == @players[@other_player].color
        @pieces_count[@other_player] -= 1
    end    
  end
  def not_within_boundary(i, j)
    i < 0 || i > 7 || j < 0 || j > 7
  end
  def not_players_pawn(i, j)
    (@board.b[i][j].color != @players[@player_playing].color)
  end
  def empty_space(i, j)
    @board.b[i][j] == '-'
  end  
  def print_error(msg)
    puts msg.red
    @invalid_move = true
  end

  def move_too_far(x, y, i, j)
    (x - i) * (x - i) + (y - j) * (y - j) != 1
  end  
  
  def move(x, y, i, j)
    @invalid_move = false
    print_error("Invalid start position") if empty_space(x,y) || not_players_pawn(x, y)
    print_error("Outside board boundaries") if not_within_boundary(i, j)
    print_error("Pawns can move only One space") if move_too_far(x, y, i, j)
    unless @invalid_move
      gp = @board.remove(x,y)
      if !empty_space(i, j)
        kill(i, j)
      end    
      @board.place(gp, i, j)
    end  
  end
  def play
    x, y = get_move_from_position
    i,j = get_move_to_position
    move(x,y,i,j)
    print "Player id: #{@player_playing} has won" if has_won?(@player_playing)
    show
    unless @invalid_move
      @player_playing ^= 1
      @other_player ^= 1
    end  
    play
  end

  def get_input
    i = gets.chomp.to_i
    j = gets.chomp.to_i
    [i, j]
  end  
  def get_move_from_position
    p "Input row and column to move from: "
    tuple = get_input
  end

  def get_move_to_position
    p "Input row and column to move to: "
    get_input
  end
  def show
    p "Now showing on request...."
    @board.print
  end
end

g = Game.new

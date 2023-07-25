require './game_piece.rb'
require './player.rb'
require './board.rb'
require 'colorize'
# Imporve initalization in board
# change @b to @board 
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

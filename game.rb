require './game_piece'
require './player'
require './board'
require 'colorize'
# Improve initalization in board
# change @b to @board
class Game
  attr_reader :board

  def initialize(board: Board.new, players: Array.new(2) { Player.new })
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

  def has_won?
    @pieces_count[@other_player] == 0
  end

  def kill(x, y, i, j)
    return unless @board.b[i][j].color == @players[@other_player].color
    if @board.b[i][j].priority <= @board.b[x][y].priority
      @pieces_count[@other_player] -= 1
    else
      print_error "Cannot kill this pawn. Your pawn is lower priority."  
      @invalid_move = true
    end      
  end

  def within_boundary?(i, j)
    i >= 0 && i <= 7 && j >= 0 && j <= 7
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
    ((x - i).abs > 1) || ((y - j).abs > 1)
  end

  def no_move(x,y,i, j)
    x == i && y == j
  end

  def validate(x, y, i, j)
    err_msg = []
    err_msg << 'Invalid start position' if empty_space(x, y) || not_players_pawn(x, y)
    err_msg << 'Outside board boundaries' unless within_boundary?(i, j)
    err_msg << 'Pawns can move only One space at a time' if move_too_far(x, y, i, j)
    err_msg << 'Pawn cant be moved to its own position' if no_move(x,y, i, j)
    return if err_msg.length == 0

    @invalid_move = true
    print_error err_msg.join(', ')
  end

  def move(x, y, i, j)
    @invalid_move = false
    validate(x, y, i, j)
    kill(x, y, i, j) unless empty_space(i, j)
    return if @invalid_move

    gp = @board.remove(x, y)
    @board.place(gp, i, j)
  end

  def play
    x, y = get_move_from_position
    i, j = get_move_to_position
    move(x, y, i, j)
    print "Player id: #{@player_playing} has won" if has_won?
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
    p 'Input row and column to move from: '
    tuple = get_input
  end

  def get_move_to_position
    p 'Input row and column to move to: '
    get_input
  end

  def show
    p 'Now showing on request....'
     @board.print
  end
end

g = Game.new

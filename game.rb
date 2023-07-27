# frozen_string_literal: true

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

  def won?
    (@pieces_count[@other_player]).zero?
  end

  def kill(from_x, from_y, to_x, to_y)
    return unless @board.b[to_x][to_y].color == @players[@other_player].color

    if @board.b[to_x][to_y].priority <= @board.b[from_x][from_y].priority
      @pieces_count[@other_player] -= 1
    else
      print_error 'Cannot kill this pawn. Your pawn is lower priority.'
      @invalid_move = true
    end
  end

  def within_boundary?(to_x, to_y)
    to_x >= 0 && to_x <= 7 && to_y >= 0 && to_y <= 7
  end

  def not_players_pawn(to_x, to_y)
    (@board.b[to_x][to_y].color != @players[@player_playing].color)
  end

  def empty_space(to_x, to_y)
    @board.b[to_x][to_y] == '-'
  end

  def print_error(msg)
    puts msg.red
    @invalid_move = true
  end

  def move_too_far(from_x, from_y, to_x, to_y)
    ((from_x - to_x).abs > 1) || ((from_y - to_y).abs > 1)
  end

  def no_move(from_x, from_y, to_x, to_y)
    from_x == to_x && from_y == to_y
  end

  def validate(from_x, from_y, to_x, to_y)
    err_msg = []
    err_msg << 'Invalid start position' if empty_space(from_x, from_y) || not_players_pawn(from_x, from_y)
    err_msg << 'Outside board boundaries' unless within_boundary?(to_x, to_y)
    err_msg << 'Pawns can move only One space at a time' if move_too_far(from_x, from_y, to_x, to_y)
    err_msg << 'Pawn cant be moved to its own position' if no_move(from_x, from_y, to_x, to_y)
    return if err_msg.empty?

    @invalid_move = true
    print_error err_msg.join(', ')
  end

  def move(from_x, from_y, to_x, to_y)
    @invalid_move = false
    validate(from_x, from_y, to_x, to_y)
    kill(from_x, from_y, to_x, to_y) unless empty_space(to_x, to_y)
    return if @invalid_move

    gp = @board.remove(from_x, from_y)
    @board.place(gp, to_x, to_y)
  end

  def play
    from_x, from_y = move_from_position
    to_x, to_y = move_to_position
    move(from_x, from_y, to_x, to_y)
    print "Player id: #{@player_playing} has won" if won?
    show
    unless @invalid_move
      @player_playing ^= 1
      @other_player ^= 1
    end
    play
  end

  def input
    x = gets.chomp.to_i
    y = gets.chomp.to_i
    [x, y]
  end

  def move_from_position
    p 'Input row and column to move from: '
    input
  end

  def move_to_position
    p 'Input row and column to move to: '
    input
  end

  def show
    p 'Now showing on request....'
    @board.print
  end
end

Game.new

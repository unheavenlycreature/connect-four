require_relative 'board'

# Manages a game of ConnectFour.
class GameManager
  def initialize(board)
    @board = board
    @current_piece = '⚪'
  end

  def play
    40.times do
      winning_turn = next_turn
      return if winning_turn

      switch_piece
    end
    puts @board
    puts "Wow, it's a draw!"
  end

  private

  def next_turn
    puts @board
    puts 'Make your move!'
    make_move
    if @board.four_in_a_row?(@current_piece)
      puts @board
      puts "#{@current_piece}  wins!"
      return true
    end
    false
  end

  def make_move
    loop do
      move = move_from_user
      begin
        @board.place(move.to_i, @current_piece)
        break
      rescue ColumnFullException
        puts @board
        puts 'That column was full. Enter a different number.'
        next
      end
    end
  end

  def move_from_user
    move = gets.chomp
    until ('0'...'6') === move
      puts @board
      puts 'Please enter a number, 0 - 6.'
      move = gets.chomp
    end
    move
  end

  def switch_piece
    @current_piece = @current_piece == '⚪' ? '⚫' : '⚪'
  end
end
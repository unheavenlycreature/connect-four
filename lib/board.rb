# frozen_string_literal: true

# Exception to raise when a player tries
# to add a piece to a column that is already full.
class ColumnFullException < StandardError
end

# Representation of a ConnectFour board.
class ConnectFourBoard
  def initialize
    @board = [
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil]
    ]
  end

  def place(column, piece)
    next_space = @board[column].find_index(&:nil?)
    raise ColumnFullException if next_space.nil?

    @board[column][next_space] = piece
  end

  def to_s
    s = ''
    printable = @board.transpose.reverse
    printable.length.times { |row| s += row_string(row, printable) }
    7.times { |index| s += "  #{index} " }
    s
  end

  def four_in_a_row?(piece)
    four_horizontal?(piece) || four_horizontal?(piece, @board.transpose) || \
      four_diagonal?(piece) || four_diagonal?(piece, @board.reverse)
  end

  def at(column, row)
    @board[column][row]
  end

  private

  def four_horizontal?(piece, board = @board)
    board.length.times do |column|
      consecutive = 0
      board[column].length.times do |row|
        if board[column][row] == piece
          consecutive += 1
          return true if consecutive == 4
        else
          consecutive = 0
        end
      end
    end
    false
  end

  def four_diagonal?(piece, board = @board)
    board.length.times do |column|
      board[column].length.times do |row|
        next if column + 3 > 7
        next if row + 3 > 6
        return true if four_diagonal_from?(piece, board, column, row)
      end
    end
    false
  end

  def four_diagonal_from?(piece, board, column, row)
    board[column][row] == piece && \
      board[column + 1][row + 1] == piece && \
      board[column + 2][row + 2] == piece && \
      board[column + 3][row + 3] == piece
  end

  def row_string(row, board)
    s = '|'
    board[row].length.times do |column|
      s += board[row][column].nil? ? '   |' : " #{board[row][column]} |"
    end
    s += "\n#{'_' * 29}\n"
    s
  end
end

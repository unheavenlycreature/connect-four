# frozen_string_literal: true

require './lib/board'

describe ConnectFourBoard do
  before(:each) do
    @board = ConnectFourBoard.new
  end

  context '#place' do
    it 'adds piece in correct position' do
      3.times { @board.place(0, '⚪') }
      3.times { |i| expect(@board.send(:at, 0,i)).to eq '⚪'}
    end

    it 'allows a max of six pieces per column' do
      3.times { @board.place(0, '⚪') }
      3.times { @board.place(0, '⚫') }
      expect { @board.place(0, '⚪') }.to raise_error ColumnFullException
    end
  end

  context '#four_in_a_row?' do
    it 'returns false when there is not four in a row' do
      3.times { |column| @board.place(column, '⚪') }
      expect(@board.four_in_a_row?('⚪')).to be false
    end

    it 'returns true for horizontal four in a row' do
      4.times { |column| @board.place(column, '⚪') }
      expect(@board.four_in_a_row?('⚪')).to be true
    end

    it 'returns true for vertical four in a row' do
      4.times { @board.place(0, '⚪') }
      expect(@board.four_in_a_row?('⚪')).to be true
    end

    it 'returns true for diagonal four in a row to the left' do
      4.times do |column|
        (3 - column).times do 
          @board.place(column, '⚫')
        end
        @board.place(column, '⚪')
      end
      expect(@board.four_in_a_row?('⚪')).to be true
    end

    it 'returns true for diagonal four in a row to the left' do
      4.times do |column|
        column.times do
          @board.place(column, '⚫')
        end
        @board.place(column, '⚪')
      end
      expect(@board.four_in_a_row?('⚪')).to be true
    end
  end
end

# frozen_string_literal: true

require './lib/game_manager'

describe GameManager do
  before(:each) do
    # Prevent class under test from writing output.
    allow($stdout).to receive(:write)
    @board = instance_double('ConnectFourBoard')
    allow(@board).to receive(:to_s).and_return('')

    @manager = GameManager.new(@board)
  end

  context '#next_turn' do
    it 'only accepts valid input' do
      allow(@manager).to receive(:gets).and_return("a\n", "0\n")
      expect(@board).not_to receive(:place).with('a', '⚪')
      expect(@board).to receive(:place).with(0, '⚪')
      expect(@board).to receive(:four_in_a_row?).with('⚪')

      @manager.send(:next_turn)
    end

    it 'outputs winning string' do
      allow(@manager).to receive(:gets).and_return("0\n")
      expect(@board).to receive(:place).with(0, '⚪')
      allow(@board).to receive(:four_in_a_row?).with('⚪').and_return(true)
      expectation = expect { @manager.send(:next_turn) }
      expectation.to output(/wins/).to_stdout
    end
  end

  context '#play' do
    it 'outputs draw string' do
      allow(@manager).to receive(:gets).at_least(40).times.and_return(
        '0', '1', '2', '3', '4', '5', '6', \
        '0', '1', '2', '3', '4', '5', '6', \
        '0', '1', '2', '3', '4', '5', '6', \
        '0', '1', '2', '3', '4', '5', '6', \
        '0', '1', '2', '3', '4', '5', '6', \
        '0', '1', '2', '3', '4', '5', '6', \
        '0', '1', '2', '3', '4', '5', '6'
      )
      expect(@board).to receive(:place).at_least(40).times
      allow(@board).to receive(:four_in_a_row?).and_return(false)

      expectation = expect { @manager.play }
      expectation.to output(/draw/).to_stdout
    end
  end
end

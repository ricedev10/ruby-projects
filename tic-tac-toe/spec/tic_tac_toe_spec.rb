# frozen_string_literal: true

require_relative '../tic_tac_toe'

describe TicTacToe do
  subject(:game) { TicTacToe.new }

  describe '#initialize' do
    # only initialize variables - no tests needed
  end

  describe '#score_point' do
    context 'when scoring an empty slot' do
      it 'scores a point successfully' do
        success = game.score_point(0, 0, 'X')
        expect(success).to be true
      end
      it 'updates @boxes' do
        expect { game.score_point(0, 0, 'X') }.to change { game.instance_variable_get(:@boxes)[0] }.from(nil).to('X')
      end
    end

    context 'when scoring an already scored slot' do
      before do
        game.score_point(0, 0, 'X')
      end
      it 'does not score a point' do
        success = game.score_point(0, 0, 'X')
        expect(success).to be false
      end

      it 'does not update @boxes' do
        expect { game.score_point(0, 0, 'X') }.not_to change { game.instance_variable_get(:@boxes) }
      end
    end

    context 'when scoring middle of board (1, 1)' do
      it 'sets @boxes array to have a value in middle' do
        expect { game.score_point(1, 1, 'X') }.to change { game.instance_variable_get(:@boxes)[4] }.from(nil).to('X')
      end
    end

    context 'when scoring bottom right of board (2, 2)' do
      it 'sets @boxes array to have a value at last' do
        expect { game.score_point(2, 2, 'X') }.to change { game.instance_variable_get(:@boxes)[8] }.from(nil).to('X')
      end
    end

    context 'when scoring top left of board (0, 0)' do
      it 'sets @boxes array to have a value at last' do
        expect { game.score_point(0, 0, 'X') }.to change { game.instance_variable_get(:@boxes)[0] }.from(nil).to('X')
      end
    end
  end

  describe '#score_at_index' do
    context 'when scoring "O" at index 0' do
      it 'add "O" to @boxes[0]' do
        expect { game.score_at_index(0, 'X') }.to change {
          game.instance_variable_get(:@boxes)[0]
        }.from(nil).to('X')
      end
    end

    context 'when scoring "X" at index 3' do
      it 'add "X" to @boxes[3]' do
        expect { game.score_at_index(3, 'X') }.to change {
          game.instance_variable_get(:@boxes)[3]
        }.from(nil).to('X')
      end
    end
  end

  describe '#find_winner' do
    context 'when no points scored' do
      it 'has no winners' do
        has_winner = game.find_winner
        expect(has_winner).to be false
      end
    end

    context 'when scoring horizontal' do
      before do
        game.score_at_index(0, 'X')
        game.score_at_index(1, 'X')
        game.score_at_index(2, 'X')
      end

      it 'has a winner' do
        has_winner = game.find_winner
        expect(has_winner).to be true
      end
    end

    context 'when scoring vertical' do
      before do
        game.score_point(0, 0, 'O')
        game.score_point(0, 1, 'O')
        game.score_point(0, 2, 'O')
      end

      it 'has a winner' do
        has_winner = game.find_winner
        expect(has_winner).to be true
      end
    end

    context 'when scoring diagonal' do
      before do
        game.score_point(0, 0, 'O')
        game.score_point(1, 1, 'O')
        game.score_point(2, 2, 'O')
      end

      it 'has a winner' do
        has_winner = game.find_winner
        expect(has_winner).to be true
      end
    end
  end

  describe '#clean_board' do
    matcher :be_all_nil do
      match { |a| a.all?(nil) }
    end

    context 'when board already contains points' do
      before do
        game.score_point(0, 0, 'X')
        game.score_at_index(3, 'X')
      end
      it 'has emptied the array' do
        expect { game.clean_board }.to change { game.instance_variable_get(:@boxes) }.to be_all_nil
      end
    end

    context 'when board is empty' do
      it 'still is empty' do
        game.clean_board
        expect(game.instance_variable_get(:@boxes)).to be_all_nil
      end
    end
  end

  describe '#full?' do
    context 'when board is empty' do
      it 'is not full' do
        expect(game).not_to be_full
      end
    end

    context 'when board is half full' do
      it 'is not full' do
        game.score_at_index(0, true)
        game.score_at_index(1, true)
        game.score_at_index(2, true)
        game.score_at_index(3, true)
        game.score_at_index(4, true)

        expect(game).not_to be_full
      end
    end

    context 'when board is full' do
      it 'is full' do
        game.score_at_index(0, true)
        game.score_at_index(1, true)
        game.score_at_index(2, true)
        game.score_at_index(3, true)
        game.score_at_index(4, true)
        game.score_at_index(5, true)
        game.score_at_index(6, true)
        game.score_at_index(7, true)
        game.score_at_index(8, true)

        expect(game).to be_full
      end
    end
  end

  describe '#to_s' do
    # only has puts -> no tests needed
  end
end

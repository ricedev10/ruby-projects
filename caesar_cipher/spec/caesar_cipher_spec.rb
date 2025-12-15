# frozen_string_literal: true

require_relative '../caesar_cipher'

describe 'CaesarCipher' do
  context 'when ciphering "ab" with shift 1' do
    it 'returns bc' do
      phrase = 'ab'
      ciphered = caesar_cipher(phrase, 1)
      expect(ciphered).to eq('bc')
    end
  end

  context 'when ciphering "bc" with negative shift -1' do
    it 'returns ab' do
      phrase = 'bc'
      ciphered = caesar_cipher(phrase, -1)
      expect(ciphered).to eq('ab')
    end
  end

  context 'when ciphering with spaces and punctuation' do
    it 'does not shift' do
      phrase = 'ab. b!'
      ciphered = caesar_cipher(phrase, 1)
      expect(ciphered).to eq('bc. c!')
    end
  end
end

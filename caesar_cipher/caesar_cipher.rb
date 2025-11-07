def caesar_cipher(string, shift)
  cipher = ""
  string.each_char do |char|
    # 97-122 [a-z], 65-90 [A-Z]
    # Cipher character if it is an alphabetical character
    if char =~ /[a-zA-Z]/
      new_ord = (char.downcase.ord + shift - 97) % 26 + 97
      new_chr = new_ord.chr

      # add to ciphered text (also keep the case of the character)
      cipher += char.downcase == char ? new_chr : new_chr.upcase 
    else
      cipher += char
    end
  end

  return cipher
end

p caesar_cipher("What a string!", 5)
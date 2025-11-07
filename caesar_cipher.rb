def caesar_cipher(string, shift)
  puts thingy
  alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ]
  cipher = ""
  string.each_char do |char|
    code = alphabet.index(char.downcase)
    if code == nil
      cipher += char
    else
      index = (code + shift) % alphabet.length
      new_char = alphabet[index]
      if char != char.downcase
        cipher += new_char.upcase
      else
        cipher += new_char
      end
    end  
  end

  return cipher
end

p caesar_cipher("What a string!", 5)
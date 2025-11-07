def substrings(pattern, word_list)
  found = Hash.new()

  # iterate over each word
  word_list.each do |word|
    does_match = !!pattern.match(word)
    (found[word] = found[word] ? found[word] + 1 : 1) if does_match
  end

  found
end

# test
p substrings("below", ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
)

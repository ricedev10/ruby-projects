rocks = File.new('rocks.txt')

while (line = rocks.gets)
  rock_data = line.chomp.split(' ')
  name = rock_data[0]
  price = rock_data[1]
  puts "Rock name: #{name}; Price: #{price}"
end
rocks.close

File.readlines('test.rb').each do |line|
  puts line
  eval(line)
end

Dir.pwd
Dir.mkdir 'new_dir' unless Dir.exist?('new_dir')
Dir.chdir 'new_dir'
puts Dir.pwd
Dir.chdir '../'
puts Dir.pwd
Dir.rmdir 'new_dir'

files = Dir.entries '.'
p files.inspect

system 'ls *.rb'
puts '-------------'
print `ls *.rb`
%x(ls *.rb) # rubocop:disable Style/CommandLiteral

puts $?.success?

if ARGV.length != 1
  $stderr.puts "usage: game_generator <game count>"
  exit(1)
end

count = ARGV[0].to_i
WORDS_PER_GAME = 14

words = []
while line = $stdin.gets
  words_this_line = line.split
  words.concat words_this_line
end

(0...count).each do 
  (0...WORDS_PER_GAME).each { puts words.sample }
  puts "*" + words.sample
  puts "------"
  puts "\n"
end

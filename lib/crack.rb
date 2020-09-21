require 'fileutils'
require './lib/enigma'

content = File.open(ARGV[0]).read
FileUtils.touch ARGV[1]
output_file = File.open(ARGV[1], "w")
enigma = Enigma.new.crack(content, ARGV[2])
output_file.write(enigma[:decryption])
puts "Created '#{ARGV[1]}' with the cracked key #{enigma[:key]} and date #{ARGV[2]}"

require 'fileutils'
require './lib/enigma'

content = File.open(ARGV[0]).read
FileUtils.touch ARGV[1]
output_file = File.open(ARGV[1], "w")
enigma = Enigma.new.decrypt(content, ARGV[2], ARGV[3])
output_file.write(enigma[:decryption])
puts "Created '#{ARGV[1]}' with the key #{ARGV[2]} and date #{ARGV[3]}"

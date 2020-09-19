require 'fileutils'
require './lib/enigma'

content = File.open(ARGV[0]).read
FileUtils.touch ARGV[1]
output_file = File.open(ARGV[1], "w")
enigma = Enigma.new.encrypt(content)
output_file.write(enigma[:encryption])
puts "Created '#{ARGV[1]}' with the key #{enigma[:key]} and date #{enigma[:date]}"

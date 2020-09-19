require './lib/generatable'

class Decryptor
  include Generatable
  attr_reader :character_set

  def initialize()
    @character_set = ("a".."z").to_a << " "
  end

  def get_decrypted_string(message, key, date)
    shifts = generate_shifts(generate_keys(key), generate_offsets(date))
    decrypted_array = []
    message.split('').each_slice(4) do |four_chars|
      decrypted_array << find_decrypted_letters(four_chars, shifts)
    end
    decrypted_array.flatten.join
  end

  def find_decrypted_letters(four_char_arr, shifts)
    four_char_arr.zip(shifts.values).map do |char, shift_value|
      next char if !@character_set.include?(char)
      @character_set.rotate(@character_set.index(char) - shift_value).first
    end
  end

end

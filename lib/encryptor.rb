require './lib/generatable'

class Encryptor
  include Generatable

  def initialize()
    @character_set = ("a".."z").to_a << " "
  end

  def get_encrypted_string(message, key, date)
    shifts = generate_shifts(generate_keys(key), generate_offsets(date))
    encrypted_array = []
    message.split('').each_slice(4) do |four_chars|
      encrypted_array << find_encrypted_letters(four_chars, shifts)
    end
    encrypted_array.flatten.join
  end

  def find_encrypted_letters(four_char_arr, shifts)
    four_char_arr.zip(shifts.values).map do |char, shift_value|
      next char if !@character_set.include?(char)
      @character_set.rotate(@character_set.index(char) + shift_value).first
    end
  end

end

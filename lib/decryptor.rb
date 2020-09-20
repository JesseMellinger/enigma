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

  #Iteration 4

  def find_key(date)
    
  end

  def find_shift_value(last_four)
    last_four.split('').zip(['d', 'n', 'e', ' ']).map do |two_char_arr|
      @character_set.index(two_char_arr[0]) - @character_set.index(two_char_arr[1])
    end
  end

  def get_decrypted_string_without_key(ciphertext)
    shifts = get_shift_hash(find_shift_value(ciphertext.reverse[0..3]))
    decrypted_array = []
    ciphertext.reverse.split('').each_slice(4) do |four_chars|
      decrypted_array << find_decrypted_letters(four_chars, shifts)
    end
    decrypted_array.flatten.join.reverse
  end

  def get_shift_hash(index_arr)
    {
      a: index_arr[0],
      b: index_arr[1],
      c: index_arr[2],
      d: index_arr[3]
    }
  end

end

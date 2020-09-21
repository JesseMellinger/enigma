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

  def find_shift(decrypted_text, ciphertext)
    shifts = decrypted_text[0..3].split('').zip(ciphertext[0..3].split('')).map do |two_char_arr|
      @character_set.index(two_char_arr[1]) - @character_set.index(two_char_arr[0])
    end
    get_positive_shift_values(shifts)
  end

  def get_positive_shift_values(shift_arr)
    shift_arr.map do |num|
      next num if num >= 0
      num + 27
    end
  end

  def find_key(decyphered_text, ciphertext, date)
    offsets = generate_offsets(date)
    shifts = get_shift_hash(find_shift(decyphered_text, ciphertext))
    ("00000".."99999").to_a.find do |num|
      num[0..1].to_i % 27 == shifts[:a] - offsets[:a].to_i &&
      num[1..2].to_i % 27 == shifts [:b] - offsets[:b].to_i &&
      num[2..3].to_i % 27 == shifts[:c] - offsets[:c].to_i &&
      num[3..4].to_i % 27 == shifts[:d] - offsets[:d].to_i
    end
  end

  def find_shift_with_last_four_characters(last_four)
    last_four.split('').zip(['d', 'n', 'e', ' ']).map do |two_char_arr|
      @character_set.index(two_char_arr[0]) - @character_set.index(two_char_arr[1]) + 27
    end
  end

  def get_decrypted_string_without_key(ciphertext)
    shifts = get_shift_hash(find_shift_with_last_four_characters(ciphertext.reverse[0..3]))
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

require 'date'

class Enigma
  attr_reader :character_set

  def initialize()
    @character_set = ("a".."z").to_a << " "
  end

  def encrypt(message, key = generate_random_key_number(), date = Date.today.strftime("%d%m%y"))
    {
      encryption: get_encrypted_string(message.downcase, generate_keys(key),
                  generate_offsets(date)),
      key: key,
      date: date
    }
  end

  def decrypt(ciphertext, key, date = Date.today.strftime("%d%m%y"))
    {
    decryption: get_decrypted_string(ciphertext.downcase, generate_keys(key),
                generate_offsets(date)),
    key: key,
    date: date
    }
  end

  def get_encrypted_string(message, keys, offsets)
    shifts = generate_shifts(keys, offsets)
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

  def get_decrypted_string(message, keys, offsets)
    shifts = generate_shifts(keys, offsets)
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

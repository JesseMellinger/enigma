require 'date'

class Enigma
  attr_reader :character_set

  def initialize()
    @character_set = ("a".."z").to_a << " "
  end

  def encrypt(message, key = generate_random_key_number(), date = Date.today.strftime("%d%m%y"))
    {
      encryption: get_encrypted_string(message.downcase, generate_keys(key), generate_offsets(date)),
      key: key,
      date: date
    }
  end

  def decrypt(ciphertext, key, date = Date.today.strftime("%d%m%y"))
    {
    decryption: get_decrypted_string(ciphertext.downcase, generate_keys(key), generate_offsets(date)),
    key: key,
    date: date
    }
  end

  def generate_random_key_number
    ("00000".."99999").to_a.sample
  end

  def generate_keys(random_num)
    {
      a: random_num[0..1],
      b: random_num[1..2],
      c: random_num[2..3],
      d: random_num[3..5]
    }
  end

  def generate_offsets(date)
    num = (date.to_i ** 2).to_s[-4..-1]

    {
      a: num[0],
      b: num[1],
      c: num[2],
      d: num[3]
    }
  end

  def generate_shifts(keys, offsets)
    {
      a: keys[:a].to_i + offsets[:a].to_i,
      b: keys[:b].to_i + offsets[:b].to_i,
      c: keys[:c].to_i + offsets[:c].to_i,
      d: keys[:d].to_i + offsets[:d].to_i
    }
  end

  def get_encrypted_string(message, keys, offsets)
    shifts = generate_shifts(keys, offsets)
    encrypted_array = []
    message.split('').each_slice(4) do |four_letters|
      encrypted_array << find_encrypted_letters(four_letters, shifts)
    end
    encrypted_array.flatten.join
  end

  def find_encrypted_letters(four_letter_arr, shifts)
    four_letter_arr.zip(shifts.values).map do |letter, shift_value|
      next letter if !@character_set.include?(letter)
      @character_set.rotate(@character_set.index(letter) + shift_value).first
    end
  end

  def get_decrypted_string(message, keys, offsets)
    shifts = generate_shifts(keys, offsets)
    decrypted_array = []
    message.split('').each_slice(4) do |four_letters|
      decrypted_array << find_decrypted_letters(four_letters, shifts)
    end
    decrypted_array.flatten.join
  end

  def find_decrypted_letters(four_letter_arr, shifts)
    four_letter_arr.zip(shifts.values).map do |letter, shift_value|
      next letter if !@character_set.include?(letter)
      @character_set.rotate(@character_set.index(letter) - shift_value).first
    end
  end

end

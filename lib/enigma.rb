require 'date'
require './lib/encryptor'
require './lib/decryptor'

class Enigma
  attr_reader :character_set

  def initialize()
    @encryptor = Encryptor.new()
    @decryptor = Decryptor.new()
  end

  def encrypt(message, key = generate_random_key_number(), date = Date.today.strftime("%d%m%y"))
    {
      encryption: @encryptor.get_encrypted_string(message.downcase, key, date),
      key: key,
      date: date
    }
  end

  def decrypt(ciphertext, key, date = Date.today.strftime("%d%m%y"))
    {
    decryption: @decryptor.get_decrypted_string(ciphertext.downcase, key, date),
    key: key,
    date: date
    }
  end

  def generate_random_key_number
    ("00000".."99999").to_a.sample
  end

  def crack(ciphertext, date = Date.today.strftime("%d%m%y"))
    decyphered_text = @decryptor.get_decrypted_string_without_key(ciphertext.downcase)
      {
        decryption: decyphered_text,
        date: date,
        key: @decryptor.find_key(decyphered_text, ciphertext.downcase, date)
      }
  end

end

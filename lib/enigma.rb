require 'date'
require './lib/generatable'

class Enigma
  include Generatable
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

end

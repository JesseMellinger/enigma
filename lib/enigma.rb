class Enigma
  attr_reader :character_set

  def initialize()
    @character_set = ("a".."z").to_a << " "
  end

  def encrypt(message, key, date)

  end

  def decrypt(ciphertext, key, date)

  end

  def generate_random_key_number
    ("00000".."99999").to_a.sample
  end

end

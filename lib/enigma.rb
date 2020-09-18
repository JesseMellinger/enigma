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

  def generate_keys
    num = generate_random_key_number()

    {
      a: num[0..1],
      b: num[1..2],
      c: num[2..3],
      d: num[3..5]
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

end

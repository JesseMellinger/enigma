class Decryptor
  include Generatable

  def initialize()
    @character_set = ("a".."z").to_a << " "
  end

end

require './test/test_helper'
require './lib/encryptor'

class EncryptorTest < Minitest::Test

  def setup
    @encryptor = Encryptor.new()
  end

  def test_it_exists
    assert_instance_of Encryptor, @encryptor
  end

  def test_get_character_set
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
                "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
                 " "]

    assert_equal expected, @encryptor.character_set
  end

end

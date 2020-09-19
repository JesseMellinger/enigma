require './test/test_helper'
require './lib/decryptor'

class DecryptorTest < Minitest::Test

  def setup
    @decryptor = Decryptor.new()
  end

  def test_it_exists
    assert_instance_of Decryptor, @decryptor
  end

  def test_get_character_set
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
                "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
                 " "]

    assert_equal expected, @decryptor.character_set
  end

  def test_get_keys
    expected = {
                a: "03",
                b: "34",
                c: "48",
                d: "89"
               }

    assert_equal expected, @decryptor.generate_keys("03489")
  end

end

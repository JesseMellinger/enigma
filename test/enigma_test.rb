require './test/test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_get_character_set
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
                "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
                 " "]

    assert_equal expected, @enigma.character_set
  end

  def test_get_random_five_digit_string
    ("00000".."99999").to_a.include? (@enigma.generate_random_key_number)
  end

  def test_get_keys
    @enigma.stubs(:generate_random_key_number).returns("03489")

    expected = {
                a: "03",
                b: "34",
                c: "48",
                d: "89"
               }

    assert_equal expected, @enigma.generate_keys
  end

end

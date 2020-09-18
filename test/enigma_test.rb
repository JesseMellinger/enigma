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
    assert ("00000".."99999").to_a.include? (@enigma.generate_random_key_number)
  end

  def test_get_keys
    expected = {
                a: "03",
                b: "34",
                c: "48",
                d: "89"
               }

    assert_equal expected, @enigma.generate_keys("03489")
  end

  def test_get_offsets
    expected = {
                a: "1",
                b: "0",
                c: "2",
                d: "5"
               }

    assert_equal expected, @enigma.generate_offsets("040895")
  end

  def test_get_shifts
    keys = @enigma.generate_keys("02715")
    offsets = @enigma.generate_offsets("040895")

    expected = {
                a: 3,
                b: 27,
                c: 73,
                d: 20
               }

    assert_equal expected, @enigma.generate_shifts(keys, offsets)
  end

  def test_get_encryption_key_and_date
    assert_equal "02715", @enigma.encrypt("message", "02715", "040895")[:key]
    assert_equal "040895", @enigma.encrypt("message", "02715", "040895")[:date]
    assert_equal "170920", @enigma.encrypt("message", "02715")[:date]
  end

  def test_encrypt
    expected =    {
                    encryption: "keder ohulw",
                    key: "02715",
                    date: "040895"
                  }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

end

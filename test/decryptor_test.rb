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

  def test_get_offsets
    expected = {
                a: "1",
                b: "0",
                c: "2",
                d: "5"
               }

    assert_equal expected, @decryptor.generate_offsets("040895")
  end

  def test_get_shifts
    keys = @decryptor.generate_keys("02715")
    offsets = @decryptor.generate_offsets("040895")

    expected = {
                a: 3,
                b: 27,
                c: 73,
                d: 20
               }

    assert_equal expected, @decryptor.generate_shifts(keys, offsets)
  end

  def test_get_decrypted_string
    assert_equal "hello world", @decryptor.get_decrypted_string("keder ohulw", "02715", "040895")
    assert_equal "hello world!", @decryptor.get_decrypted_string("keder ohulw!", "02715", "040895")
  end

  def test_find_decrypted_letters
    four_letter_arr = ['k', 'e', 'd', 'e']
    shifts = { a: 3, b: 27, c: 73, d: 20 }
    assert_equal ['h', 'e', 'l', 'l'], @decryptor.find_decrypted_letters(four_letter_arr, shifts)
  end

end

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

  def test_get_keys
    expected = {
                a: "03",
                b: "34",
                c: "48",
                d: "89"
               }

    assert_equal expected, @encryptor.generate_keys("03489")
  end

  def test_get_offsets
    expected = {
                a: "1",
                b: "0",
                c: "2",
                d: "5"
               }

    assert_equal expected, @encryptor.generate_offsets("040895")
  end

  def test_get_shifts
    keys = @encryptor.generate_keys("02715")
    offsets = @encryptor.generate_offsets("040895")

    expected = {
                a: 3,
                b: 27,
                c: 73,
                d: 20
               }

    assert_equal expected, @encryptor.generate_shifts(keys, offsets)
  end

  def test_get_encrypted_string
    assert_equal "keder ohulw", @encryptor.get_encrypted_string("hello world", "02715", "040895")
    assert_equal "keder ohulw!", @encryptor.get_encrypted_string("hello world!", "02715", "040895")
  end

  def test_find_encrypted_letters
    four_letter_arr = ['h', 'e', 'l', 'l']
    shifts = { a: 3, b: 27, c: 73, d: 20 }
    assert_equal ['k', 'e', 'd', 'e'], @encryptor.find_encrypted_letters(four_letter_arr, shifts)
  end

end

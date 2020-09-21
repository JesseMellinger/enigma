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

  def test_find_shift_between_encrypted_and_decrypted_text
    decrypted_text = "hello world end"
    encrypted_text = "vjqtbeaweqihssi"
    assert_equal [14, 5, 5, 8], @decryptor.find_shift(decrypted_text, encrypted_text)
  end

  def test_get_positive_shift_values
    assert_equal [14, 5, 5, 8], @decryptor.get_positive_shift_values([14, -22, 5, -19])
  end

  def test_finding_key
    decrypted_text = "hello world end"
    encrypted_text = "vjqtbeaweqihssi"
    date = "291018"
    assert_equal "08304", @decryptor.find_key(decrypted_text, encrypted_text, date)
  end

  def test_finding_shift_based_off_of_last_four_chars
    assert_equal [32, 32, 41, 8], @decryptor.find_shift_with_last_four_characters('issh')
  end

  def test_get_decrypted_string_without_key
    encrypted_text = "vjqtbeaweqihssi"
    decrypted_text = "hello world end"

    assert_equal decrypted_text, @decryptor.get_decrypted_string_without_key(encrypted_text)
  end

  def test_get_shift_hash
    expected = {
                a: 32,
                b: 32,
                c: 41,
                d: 8
              }

    assert_equal expected, @decryptor.get_shift_hash([32, 32, 41, 8])
  end

end

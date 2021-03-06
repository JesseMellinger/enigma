require './test/test_helper'
require './lib/enigma'
require 'date'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_get_random_five_digit_string
    assert_includes ("00000".."99999").to_a, @enigma.generate_random_key_number
  end

  def test_get_encryption_hash
    expected =    {
                    encryption: "keder ohulw",
                    key: "02715",
                    date: "040895"
                  }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
    assert_equal expected, @enigma.encrypt("HELLO WORLD", "02715", "040895")
    assert_equal "keder ohulw!", @enigma.encrypt("hello world!", "02715", "040895")[:encryption]
  end

  def test_get_encryption_key_and_date
    assert_equal "02715", @enigma.encrypt("message", "02715", "040895")[:key]
    assert_equal "040895", @enigma.encrypt("message", "02715", "040895")[:date]
    assert_equal Date.today.strftime("%d%m%y"), @enigma.encrypt("message", "02715")[:date]
  end

  def test_get_decryption_hash
    expected =    {
                    decryption: "hello world",
                    key: "02715",
                    date: "040895"
                  }

    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_get_decryption_key_and_date
    assert_equal "02715", @enigma.decrypt("message", "02715", "040895")[:key]
    assert_equal "040895", @enigma.decrypt("message", "02715", "040895")[:date]
    assert_equal Date.today.strftime("%d%m%y"), @enigma.decrypt("message", "02715")[:date]
  end

  def test_get_crack_hash_with_date_provided
    expected =   {
                  decryption: "hello world end",
                  date: "291018",
                  key: "08304"
                 }

    assert_equal expected, @enigma.crack("vjqtbeaweqihssi", "291018")
  end

  def test_get_crack_hash_without_date_provided
    ciphertext = @enigma.encrypt("hello world end", "08304")[:encryption]
    expected =   {
                  decryption: "hello world end",
                  date: Date.today.strftime("%d%m%y"),
                  key: "08304"
                 }

    assert_equal expected, @enigma.crack(ciphertext)
  end

end

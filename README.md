# Enigma

Welcome to my Enigma machine in Ruby!

## Description

This project provides a program for encrypting and decrypting text based off of shift values similar to those found in a Caesar Cipher. These shift values are created using a random five-digit number (user-provided or otherwise) and a date (either user-provided or defaulted to date of transmission). Output files are created with encrypted and decrypted text respectively.

## Usage

After `cloning` the project simply run the `encrypt.rb` runner file from the terminal passing in the file to be encrypted and the desired output file like so:

``` 
$ ruby ./lib/encrypt.rb message.txt encrypted.txt
```

A confirmation message will be printed to the terminal informing the user that the file written to has been created along with the key and date used.

```
Created 'encrypted.txt' with the key 82648 and date 240818
```

When decrypting the file run the `decrypt.rb` runner file from the terminal passing in the file containing the encrypted message, the output file for the decrypted message, the key used for the decryption, and the date.

```
$ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 240818
```

Again a confirmation message will be printed to the terminal informing the user of the file created and written to along with the key and the date.

```
Created 'decrypted.txt' with the key 82648 and date 240818
```

A `crack` method is also available that allows the user to decrypt a message without supplying a key. A date may be given to this method as well and if not, today's date is used by default. Encrypt the message just as before, but instead run the `crack` runner file like so:

```
ruby ./lib/crack.rb encrypted.txt cracked.txt 240818
```

The first argument (`encrypted.txt`) is the file containing the encrypted text to be translated. The second argument (`cracked.txt`) is the file to be written to and the six-digit number represents the date given in the form DDMMYY. A confirmation message will be printed to the terminal as before with the key discovered.

```
Created 'cracked.txt' with the cracked key 82648 and date 240818
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Self-Assessment

Functionality: 4

OOP: 4

Ruby Conventions and Mechanics: 4

TDD: 3

Version Control: 4

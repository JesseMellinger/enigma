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

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

import 'dart:convert';

//import 'package:encrypt/encrypt.dart';

import 'package:encrypt/encrypt.dart';

class EncryptData {
  // static Encrypted encrypted;
  // static var decrypted;
  //final key = Key.fromUtf8('Y2RscEB0ZXN0MTIz');

  static String encryptAES(plainText) {
    //final key = Key.fromUtf8(getEncryptionKey());
    final key = Key.fromUtf8('4a9a35f23fcee2ce575a94ed5a263725');

    //this_is_a_valid_AES_key_32_bytes');
    final iv = IV.fromUtf8(getFixedIV());
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    // print(encrypted);
    final output = encrypted.base64;
    // print(output);
    print(output);
    return output;
  }

  // static String getEncryptionKey() {
  //   // Implement your logic to get the encryption key
  //   return base64Decode('Y2RscEB0ZXN0MTIz');
  // }

  // static String getFixedIV() {
  //   return base64Decode('MTIzNDU2Nzg5MDEyMzQ1Ng==');
  // }

  static String getFixedIV() {
    return 'cf42418956f5f929';
    
    //'MTIzNDU2Nzg5MDEyMzQ1Ng==';

    //'1234567891234567';
  }

  static String base64Decode(String input) {
    return utf8.decode(base64.decode(input));
  }

//hd5o1GWwsYnav2uUuvl/Jw==

  static decryptAES(String plainText) {
    //final key = Key.fromUtf8(getEncryptionKey());
    //  print(plainText);
    try {
      final key = Key.fromUtf8('4a9a35f23fcee2ce575a94ed5a263725');
      final iv = IV.fromUtf8(getFixedIV());
      final encrypter =
          Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
      final paddedCipherText = _addBase64Padding(plainText);
      final input = paddedCipherText;
      //final encryptedBytes = base64.decode(plainText);
      //print(encryptedBytes);
      final decrypted = encrypter.decrypt64(input, iv: iv);
      print(decrypted);
      return decrypted;
    } catch (e) {
      print('Decryption error: $e');
      return "";
    }
  }
  //MTFXN01pS0xXckVKK0s5cW94Q0dHZz09

  static String padData(String data, int blockSize) {
    final padLength = blockSize - (data.length % blockSize);
    final padding = String.fromCharCode(padLength) * padLength;
    return data + padding;
  }

  static String _addBase64Padding(String input) {
    // Add padding characters ('=') to ensure the input string is properly padded for base64 decoding
    final paddingLength = input.length % 4;
    if (paddingLength == 0) {
      return input;
    } else {
      return input + '=' * (4 - paddingLength);
    }
  }
}

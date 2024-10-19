import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';

class EncryptionService {
  final String encryptionKey;

  EncryptionService({
    required this.encryptionKey,
  });

  /// Encrypts the given payload using RSA encryption.
  Uint8List encryptPayload(String payload) {
    return encrypt(payload, encryptionKey);
  }

  Uint8List encrypt(String data, String publicXml) {
    // Convert the data to bytes
    Uint8List dataBytes = Uint8List.fromList(utf8.encode(data));
    //print('Raw data bytes: ${dataBytes}'); // Log the raw data bytes

    // Decode the Base64-encoded public XML
    String decodedString = utf8.decode(base64.decode(publicXml));
    String modulusString = getXmlComponent(decodedString, "Modulus");
    String exponentString = getXmlComponent(decodedString, "Exponent");

    // Convert Base64 strings to byte arrays
    Uint8List modulusBytes = base64.decode(modulusString);
    Uint8List exponentBytes = base64.decode(exponentString);

    // Log modulus and exponent bytes
    //print('Modulus bytes: $modulusBytes');
    //print('Exponent bytes: $exponentBytes');

    // Convert the byte arrays to BigInt
    BigInt modulus = BigInt.parse(_bytesToHex(modulusBytes), radix: 16);
    BigInt exponent = BigInt.parse(_bytesToHex(exponentBytes), radix: 16);

    // Create the public key using RSAPublicKey
    RSAPublicKey publicKey = RSAPublicKey(modulus, exponent);

    // Prepare data with PKCS#1 v1.5 padding
    Uint8List paddedData = _padPKCS1v15(dataBytes, modulus.bitLength ~/ 8);
    //print('Padded data: $paddedData'); // Log the padded data

    // Initialize the RSA engine for encryption
    RSAEngine rsaEngine = RSAEngine()
      ..init(true, PublicKeyParameter<RSAPublicKey>(publicKey));

    // Encrypt the padded data
    Uint8List encryptedBytes = rsaEngine.process(paddedData);
    return encryptedBytes;
  }

  Uint8List _padPKCS1v15(Uint8List data, int keySize) {
    if (data.length > keySize - 11) {
      throw Exception('Data too long for PKCS#1 v1.5 padding');
    }

    // PKCS#1 v1.5 padding format
    int paddingLength = keySize - data.length - 3;

    // Generate consistent padding
    Uint8List padding = Uint8List(paddingLength);
    for (int i = 0; i < paddingLength; i++) {
      padding[i] = 0xFF; // Use 0xFF for consistent padding
    }

    // Construct the padded message
    return Uint8List.fromList([
      0x00, // First byte
      0x02, // Second byte
      ...padding, // Random padding bytes
      0x00, // Separator
      ...data // Actual data
    ]);
  }

  String getXmlComponent(String xmlString, String field) {
    final startTag = '<$field>';
    final endTag = '</$field>';
    final startIndex = xmlString.indexOf(startTag) + startTag.length;
    final endIndex = xmlString.indexOf(endTag);

    if (startIndex >= 0 && endIndex >= 0 && startIndex < endIndex) {
      return xmlString.substring(startIndex, endIndex);
    }
    return "";
  }

  // Helper function to convert bytes to hexadecimal string
  String _bytesToHex(Uint8List bytes) {
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
  }
}

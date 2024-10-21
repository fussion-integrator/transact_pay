import 'package:example/rsa_helper.dart';
import 'package:test/test.dart';
import 'dart:typed_data';

void main() {
  group('Encrypt Function Tests', () {
    test('Encryption returns valid Uint8List', () {
      // Sample JSON data
      String jsonData = '''{
        "customer": {
          "firstname": "transact",
          "lastname": "pay",
          "mobile": "+2348134543421",
          "country": "NG",
          "email": "email@transactpay.ai"
        },
        "order": {
          "amount": 100,
          "reference": "12121212112",
          "description": "Pay",
          "currency": "NGN"
        },
        "payment": {
          "RedirectUrl": "https://www.hi.com"
        }
      }''';

      // Public XML key (sample)
      String publicXml =
          "NDA5NiE8UlNBS2V5VmFsdWU+PE1vZHVsdXM+cW5rdlhOWHRYdEF0Mi9RcDB4SzBSUXpXYTVKRWc5T0xTNFBqYzZKcmN1eDg4bmJsd2Fyd0h4dnlrUy9STk92eFltU2ZPTlEzbW9vM1hhaWpXd2IwbnVVOTJ4anBmSzByb0FYaFo0emdHVUdlS081emY4enlncExTYzFqS05MMFNXZHZWYndMeTN3WHJiRTBrSjZJRWVvSThLRSs0anRndzY1R084Z3hJeGpibjhNemI5YVNreFdaSnVMRFRLNzJHcGcxYkwrNDBLYnVNc2tVWlJVTGxhNC84Y1dYSlpId2JINjRWNkNHQlVMMGVQUmQ4dnB3aEhySzhZSlZaRGxuYTdNbmxQVjdoeGg1Q0dabkVsNy91WEJjaGYvTExLOFNyckdnRWN1anFKWEZxMm9nUlEwNzBxN2RmOXBNZ0Q5YXpTK3dya2dBck9wNnVFcXBFQ1NnbXlvb1VMZFV2MTBhQk4xRUN5YTY2UnhuV3dEck5QZktSWjU4ZmFlNnJkelpMaExlajNId2VJRjZYcHpwL280VTlmVDVwOFNWTStHK1FZalFFV0RieldhYzMyMUIxRVhWc2xkMXFFTDJzZEk0UEFWNy9DWUcwS2hvR256NVdyZnNBQ1lRRUFkQm16MXM1NktYZnczV3dYVDJoUE1xWWtTZ2c4ejFiR1AxWTZJeDU3RHViUjdVcDlwc2taV0ptUzdNdkM1NnRHN1F6OUdiNzBjVTRiNXYvYkdBZnNMNUlRanBrc2QyRENsU2U0Vm5oNEcyWE0xeTEzS0gyZWVvNnViMUczdVBUMGtzZ2RxSXRtdjFKcmN3SThWaXJOWG9oeW1xL2xpbWg1VUhDTWhzMUhlUTQwMXIvNWt0S200bDJISFMvdXhNcmZlUmVEVTRWMXVBZTNQRU1jUDg9PC9Nb2R1bHVzPjxFeHBvbmVudD5BUUFCPC9FeHBvbmVudD48L1JTQUtleVZhbHVlPg==";

      // Call the encryption function
      Uint8List encryptedData = encrypt(jsonData, publicXml);

      // Assert the result is a non-empty Uint8List
      expect(encryptedData, isNotNull);
      expect(encryptedData, isA<Uint8List>());
      expect(encryptedData.isNotEmpty, true);
    });

    test('Encryption fails for invalid public XML', () {
      // Invalid public XML
      String invalidPublicXml = "invalid_base64_string";

      // Sample JSON data
      String jsonData = '''{
        "customer": {
          "firstname": "transact",
          "lastname": "pay"
        }
      }''';

      // Expect an exception to be thrown
      expect(() => encrypt(jsonData, invalidPublicXml),
          throwsA(isA<FormatException>()));
    });
  });
}

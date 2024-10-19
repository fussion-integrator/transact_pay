import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:transact_pay/transact_pay.dart';

void main() {
  group('TransactPay', () {
    late TransactPay transactPay; // Use late keyword

    setUp(() {
      transactPay = TransactPay(
        apiKey: 'PGW-PUBLICKEY-TEST-5D9411AB210740019FF1374C896D86D0',
        encryptionKey:
            'your-encryption-key', // Replace with your actual encryption key
      );
    });

    test('should encrypt data correctly', () {
      String data = 'Hello, TransactPay!';

      // Your public XML key (make sure it is correct)
      String publicXml =
          "NDA5NiE8UlNBS2V5VmFsdWU+PE1vZHVsdXM+cW5rdlhOWHRYdEF0Mi9RcDB4SzBSUXpXYTVKRWc5T0xTNFBqYzZKcmN1eDg4bmJsd2Fyd0h4dnlrUy9STk92eFltU2ZPTlEzbW9vM1hhaWpXd2IwbnVVOTJ4anBmSzByb0FYaFo0emdHVUdlS081emY4enlncExTYzFqS05MMFNXZHZWYndMeTN3WHJiRTBrSjZJRWVvSThLRSs0anRndzY1R084Z3hJeGpibjhNemI5YVNreFdaSnVMRFRLNzJHcGcxYkwrNDBLYnVNc2tVWlJVTGxhNC84Y1dYSlpId2JINjRWNkNHQlVMMGVQUmQ4dnB3aEhySzhZSlZaRGxuYTdNbmxQVjdoeGg1Q0dabkVsNy91WEJjaGYvTExLOFNyckdnRWN1anFKWEZxMm9nUlEwNzBxN2RmOXBNZ0Q5YXpTK3dya2dBck9wNnVFcXBFQ1NnbXlvb1VMZFV2MTBhQk4xRUN5YTY2UnhuV3dEck5QZktSWjU4ZmFlNnJkelpMaExlajNId2VJRjZYcHpwL280VTlmVDVwOFNWTStHK1FZalFFV0RieldhYzMyMUIxRVhWc2xkMXFFTDJzZEk0UEFWNy9DWUcwS2hvR256NVdyZnNBQ1lRRUFkQm16MXM1NktYZnczV3dYVDJoUE1xWWtTZ2c4ejFiR1AxWTZJeDU3RHViUjdVcDlwc2taV0ptUzdNdkM1NnRHN1F6OUdiNzBjVTRiNXYvYkdBZnNMNUlRanBrc2QyRENsU2U0Vm5oNEcyWE0xeTEzS0gyZWVvNnViMUczdVBUMGtzZ2RxSXRtdjFKcmN3SThWaXJOWG9oeW1xL2xpbWg1VUhDTWhzMUhlUTQwMXIvNWt0S200bDJISFMvdXhNcmZlUmVEVTRWMXVBZTNQRU1jUDg9PC9Nb2R1bHVzPjxFeHBvbmVudD5BUUFCPC9FeHBvbmVudD48L1JTQUtleVZhbHVlPg==";

      // Perform encryption
      var encryptedData = transactPay.encrypt(data, publicXml);

      // Ensure that the encrypted data is not empty
      expect(encryptedData, isNotEmpty);
      print('Encrypted Data: ${base64.encode(encryptedData)}');
    });

    test('should create an order successfully', () async {
      final response = await transactPay.createOrder({
        'amount': 1000,
        'currency': 'USD',
        // Add other required fields
      });

      // Ensure the response is successful
      expect(response.statusCode, 200);
      // Optionally, check the response body for expected data
      var body = json.decode(response.body);
      expect(body['status'], 'success'); // Adjust based on expected response
    });

    // Add more tests for other methods like payWithCard, payWithBankTransfer, etc.
  });
}

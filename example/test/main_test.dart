import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:transact_pay/transact_pay.dart';

// Create a MockClient class to mock the http.Client
class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient mockClient; // Declare MockClient
  late TransactPay transactPay; // Declare TransactPay

  setUp(() {
    mockClient = MockClient();
    transactPay = TransactPay(
      apiKey: "PGW-PUBLICKEY-TEST-5D9411AB210740019FF1374C896D86D0",
      encryptionKey: "NDA5NiE8UlNBS2V5VmFsdWU+PE1v...",
    );
  });

  group('TransactPay API Tests', () {
    test('Create Order returns a successful response', () async {
      final createOrderPayload = {
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
        "payment": {"RedirectUrl": "https://www.hi.com"}
      };

      // Mock the API response
      when(mockClient.post(
        Uri.parse('https://api.transactpay.ai/create_order'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{"status":"success"}', 200));

      final response = await transactPay.createOrder(createOrderPayload);

      expect(response.statusCode, 200);
      expect(response.body, '{"status":"success"}');
    });

    test('Pay with Card returns a successful response', () async {
      final payWithCardPayload = {
        "reference": "1234asd",
        "paymentoption": "C",
        "country": "NG",
        "card": {
          "cardnumber": "5123450000784608",
          "expirymonth": "01",
          "expiryyear": "39",
          "cvv": "193"
        }
      };

      // Mock the API response
      when(mockClient.post(
        Uri.parse('https://api.transactpay.ai/pay_with_card'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{"status":"success"}', 200));

      final response = await transactPay.payWithCard(payWithCardPayload);

      expect(response.statusCode, 200);
      expect(response.body, '{"status":"success"}');
    });

    test('Order Status returns a successful response', () async {
      final orderStatusPayload = {"reference": "1234asd"};

      // Mock the API response
      when(mockClient.post(
        Uri.parse('https://api.transactpay.ai/order_status'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{"status":"success"}', 200));

      final response = await transactPay.orderStatus(orderStatusPayload);

      expect(response.statusCode, 200);
      expect(response.body, '{"status":"success"}');
    });
  });
}

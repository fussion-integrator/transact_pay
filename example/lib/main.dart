import 'package:transact_pay/transact_pay.dart';
import 'package:http/http.dart' as http;

void main() async {
  // Example API Key and Encryption Key
  String apiKey = "PGW-PUBLICKEY-TEST-5D9411AB210740019FF1374C896D86D0";
  String encryptionKey =
      "NDA5NiE8UlNBS2V5VmFsdWU+PE1vZHVsdXM+cW5rdlhOWHRYdEF0Mi9RcDB4SzBSUXpXYTVKRWc5T0xTNFBqYzZKcmN1eDg4bmJsd2Fyd0h4dnlrUy9STk92eFltU2ZPTlEzbW9vM1hhaWpXd2IwbnVVOTJ4anBmSzByb0FYaFo0emdHVUdlS081emY4enlncExTYzFqS05MMFNXZHZWYndMeTN3WHJiRTBrSjZJRWVvSThLRSs0anRndzY1R084Z3hJeGpibjhNemI5YVNreFdaSnVMRFRLNzJHcGcxYkwrNDBLYnVNc2tVWlJVTGxhNC84Y1dYSlpId2JINjRWNkNHQlVMMGVQUmQ4dnB3aEhySzhZSlZaRGxuYTdNbmxQVjdoeGg1Q0dabkVsNy91WEJjaGYvTExLOFNyckdnRWN1anFKWEZxMm9nUlEwNzBxN2RmOXBNZ0Q5YXpTK3dya2dBck9wNnVFcXBFQ1NnbXlvb1VMZFV2MTBhQk4xRUN5YTY2UnhuV3dEck5QZktSWjU4ZmFlNnJkelpMaExlajNId2VJRjZYcHpwL280VTlmVDVwOFNWTStHK1FZalFFV0RieldhYzMyMUIxRVhWc2xkMXFFTDJzZEk0UEFWNy9DWUcwS2hvR256NVdyZnNBQ1lRRUFkQm16MXM1NktYZnczV3dYVDJoUE1xWWtTZ2c4ejFiR1AxWTZJeDU3RHViUjdVcDlwc2taV0ptUzdNdkM1NnRHN1F6OUdiNzBjVTRiNXYvYkdBZnNMNUlRanBrc2QyRENsU2U0Vm5oNEcyWE0xeTEzS0gyZWVvNnViMUczdVBUMGtzZ2RxSXRtdjFKcmN3SThWaXJOWG9oeW1xL2xpbWg1VUhDTWhzMUhlUTQwMXIvNWt0S200bDJISFMvdXhNcmZlUmVEVTRWMXVBZTNQRU1jUDg9PC9Nb2R1bHVzPjxFeHBvbmVudD5BUUFCPC9FeHBvbmVudD48L1JTQUtleVZhbHVlPg==";

  // Create an instance of TransactPay
  TransactPay transactPay = TransactPay(
    apiKey: apiKey,
    encryptionKey: encryptionKey,
  );

  // Create an order example
  //----------------------------------------------------------------------------

  // Create an order payload
  Map<String, dynamic> createOrderPayload = {
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

  // Call the create order method
  try {
    http.Response createOrderResponse =
        await transactPay.createOrder(createOrderPayload);
    print('Create Order Response: ${createOrderResponse.statusCode}');
    print('Response Body: ${createOrderResponse.body}');
  } catch (e) {
    print('Error creating order: $e');
  }

  // Pay with Card example
  //----------------------------------------------------------------------------

  // Pay with card payload
  Map<String, dynamic> payWithCardPayload = {
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

  // Call the paywithcard method
  try {
    http.Response payWithCardResponse =
        await transactPay.payWithCard(payWithCardPayload);
    print('Order Status Response: ${payWithCardResponse.statusCode}');
    print('Response Body: ${payWithCardResponse.body}');
  } catch (e) {
    print('Error paying with card: $e');
  }

  // Order status example
  //----------------------------------------------------------------------------

  // Order status payload
  Map<String, dynamic> orderStatusPayload = {"reference": "1234asd"};
  // Call the order status method
  try {
    http.Response statusResponse =
        await transactPay.orderStatus(orderStatusPayload);
    print('Order Status Response: ${statusResponse.statusCode}');
    print('Response Body: ${statusResponse.body}');
  } catch (e) {
    print('Error fetching order status: $e');
  }

  // Verify Order example
  //----------------------------------------------------------------------------

  // Verify order payload
  Map<String, dynamic> verifyOrderPayload = {"reference": "1234asd"};
  // Call the verify order method
  try {
    http.Response verifyOrderResponse =
        await transactPay.verifyOrder(verifyOrderPayload);
    print('Order Status Response: ${verifyOrderResponse.statusCode}');
    print('Response Body: ${verifyOrderResponse.body}');
  } catch (e) {
    print('Error verifying order: $e');
  }

  // Save Card example
  //----------------------------------------------------------------------------

  // Save card payload
  Map<String, dynamic> saveCardPayload = {"reference": "1234asd"};
  // Call the save card method
  try {
    http.Response saveCardResponse =
        await transactPay.saveCard(saveCardPayload);
    print('Order Status Response: ${saveCardResponse.statusCode}');
    print('Response Body: ${saveCardResponse.body}');
  } catch (e) {
    print('Error saving card: $e');
  }

  // Order fee example
  //----------------------------------------------------------------------------

  // Order fee payload
  Map<String, dynamic> orderFeePayload = {
    "amount": 100,
    "currency": "USD",
    "paymentoption": "C"
  };
  // Call the order fee method
  try {
    http.Response orderFeeResponse =
        await transactPay.orderFee(orderFeePayload);
    print('Order Status Response: ${orderFeeResponse.statusCode}');
    print('Response Body: ${orderFeeResponse.body}');
  } catch (e) {
    print('Error fetching order fee: $e');
  }

  // Track Event example
  //----------------------------------------------------------------------------

  // Track event payload
  Map<String, dynamic> trackEventPayload = {};
  // Call the track event method
  try {
    http.Response trackEventResponse =
        await transactPay.trackEvents(trackEventPayload);
    print('Order Status Response: ${trackEventResponse.statusCode}');
    print('Response Body: ${trackEventResponse.body}');
  } catch (e) {
    print('Error tracking event: $e');
  }

  // Banks example
  //----------------------------------------------------------------------------

  // Banks payload
  Map<String, dynamic> banksPayload = {};
  // Call the banks method
  try {
    http.Response banksResponse = await transactPay.banks();
    print('Order Status Response: ${banksResponse.statusCode}');
    print('Response Body: ${banksResponse.body}');
  } catch (e) {
    print('Error fetching banks: $e');
  }

  // Get payment link example
  //----------------------------------------------------------------------------

  // Payment link payload
  Map<String, dynamic> paymentLinPayload = {"reference": "1234asd"};
  // Call the payment link method
  try {
    http.Response paymentLinkResponse =
        await transactPay.getPaymentLink(paymentLinPayload);
    print('Order Status Response: ${paymentLinkResponse.statusCode}');
    print('Response Body: ${paymentLinkResponse.body}');
  } catch (e) {
    print('Error fetching payment link: $e');
  }

  // Order status example
  //----------------------------------------------------------------------------

  // Payment key payload
  Map<String, dynamic> paymentKeyPayload = {};
  // Call the order status method
  try {
    http.Response paymentKeyResponse =
        await transactPay.getPaymentKeys(paymentKeyPayload);
    print('Order Status Response: ${paymentKeyResponse.statusCode}');
    print('Response Body: ${paymentKeyResponse.body}');
  } catch (e) {
    print('Error fetching payment key: $e');
  }
}

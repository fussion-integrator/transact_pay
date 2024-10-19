// lib/api.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:transact_pay/services/encryption_service.dart';
import 'constants.dart';

class TransactPayApi {
  final String apiKey;
  final EncryptionService encryptionService;

  TransactPayApi({
    required this.apiKey,
    required String encryptionKey,
  }) : encryptionService = EncryptionService(encryptionKey: encryptionKey);

  /// Makes an API request to the given endpoint with encrypted payload.
  Future<http.Response> makeApiRequest(
    String endpoint,
    Map<String, dynamic> body,
    String method,
  ) async {
    // Encrypt the body
    String bodyString = json.encode(body);
    Uint8List encryptedBody = encryptionService.encryptPayload(bodyString);
    String encryptedBase64 = base64.encode(encryptedBody);

    // Prepare the request
    var headers = {
      'api-key': apiKey,
      'Content-Type': 'application/json',
    };

    // Create the request based on the method
    var request = http.Request(method, Uri.parse(endpoint));
    request.headers.addAll(headers);
    request.body = json.encode({"data": encryptedBase64});

    // Send the request and return the response
    return await http.Client().send(request).then((response) async {
      return await http.Response.fromStream(response);
    });
  }

  // API request methods with appropriate HTTP methods

  Future<http.Response> createOrder(Map<String, dynamic> orderDetails) {
    return makeApiRequest(ApiEndpoints.createOrder, orderDetails, 'POST');
  }

  Future<http.Response> payWithCard(Map<String, dynamic> paymentDetails) {
    return makeApiRequest(ApiEndpoints.payWithCard, paymentDetails, 'POST');
  }

  Future<http.Response> payWithBankTransfer(
      Map<String, dynamic> paymentDetails) {
    return makeApiRequest(
        ApiEndpoints.payWithBankTransfer, paymentDetails, 'POST');
  }

  Future<http.Response> orderStatus(Map<String, dynamic> orderId) {
    return makeApiRequest(
        ApiEndpoints.orderStatus, {"orderId": orderId}, 'POST');
  }

  Future<http.Response> verifyOrder(Map<String, dynamic> orderId) {
    return makeApiRequest(ApiEndpoints.verifyOrder, orderId, 'POST');
  }

  Future<http.Response> saveCard(Map<String, dynamic> cardDetails) {
    return makeApiRequest(ApiEndpoints.saveCard, cardDetails, 'PATCH');
  }

  Future<http.Response> orderFee(Map<String, dynamic> feeDetails) {
    return makeApiRequest(ApiEndpoints.orderFee, feeDetails, 'POST');
  }

  Future<http.Response> trackEvents(Map<String, dynamic> eventDetails) {
    return makeApiRequest(ApiEndpoints.trackEvents, eventDetails, 'POST');
  }

  Future<http.Response> banks() {
    return makeApiRequest(ApiEndpoints.banks, {}, 'GET');
  }

  Future<http.Response> getPaymentLink(Map<String, dynamic> linkDetails) {
    return makeApiRequest(ApiEndpoints.getPaymentLink, linkDetails, 'GET');
  }

  Future<http.Response> getPaymentKeys(Map<String, dynamic> linkDetails) {
    return makeApiRequest(ApiEndpoints.getPaymentKeys, {}, 'POST');
  }

  Future<http.Response> tokenizeCharge(Map<String, dynamic> chargeDetails) {
    return makeApiRequest(ApiEndpoints.tokenizeCharge, chargeDetails, 'POST');
  }

  Future<http.Response> refundOrder(Map<String, dynamic> refundDetails) {
    return makeApiRequest(ApiEndpoints.refundOrder, refundDetails, 'POST');
  }
}

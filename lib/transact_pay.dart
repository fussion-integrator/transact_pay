// lib/transact_pay.dart

import 'api.dart';
import 'package:http/http.dart' as http;

class TransactPay {
  final String apiKey;
  final String encryptionKey;
  late final TransactPayApi _api;

  TransactPay({
    required this.apiKey,
    required this.encryptionKey,
  }) {
    _api = TransactPayApi(apiKey: apiKey, encryptionKey: encryptionKey);
  }

  Future<http.Response> createOrder(Map<String, dynamic> orderDetails) {
    return _api.createOrder(orderDetails);
  }

  Future<http.Response> payWithCard(Map<String, dynamic> paymentDetails) {
    return _api.payWithCard(paymentDetails);
  }

  Future<http.Response> payWithBankTransfer(
      Map<String, dynamic> paymentDetails) {
    return _api.payWithBankTransfer(paymentDetails);
  }

  Future<http.Response> orderStatus(Map<String, dynamic> orderId) {
    return _api.orderStatus(orderId);
  }

  Future<http.Response> verifyOrder(Map<String, dynamic> orderId) {
    return _api.verifyOrder(orderId);
  }

  Future<http.Response> saveCard(Map<String, dynamic> cardDetails) {
    return _api.saveCard(cardDetails);
  }

  Future<http.Response> orderFee(Map<String, dynamic> feeDetails) {
    return _api.orderFee(feeDetails);
  }

  Future<http.Response> trackEvents(Map<String, dynamic> eventDetails) {
    return _api.trackEvents(eventDetails);
  }

  Future<http.Response> banks() {
    return _api.banks();
  }

  Future<http.Response> getPaymentLink(Map<String, dynamic> linkDetails) {
    return _api.getPaymentLink(linkDetails);
  }

  Future<http.Response> getPaymentKeys(Map<String, dynamic> linkDetails) {
    return _api.getPaymentKeys(linkDetails);
  }

  Future<http.Response> tokenizeCharge(Map<String, dynamic> chargeDetails) {
    return _api.tokenizeCharge(chargeDetails);
  }

  Future<http.Response> refundOrder(Map<String, dynamic> refundDetails) {
    return _api.refundOrder(refundDetails);
  }
}

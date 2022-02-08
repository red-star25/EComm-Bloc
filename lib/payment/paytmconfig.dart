import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

class PaytmConfig {
  final String _mid = dotenv.env['M_ID']!;
  final String _mKey = dotenv.env['M_KEY']!;
  final String _website = 'DEFAULT';
  final String _url =
      'https://flutter-paytm-backend.herokuapp.com/generateTxnToken';

  String get mid => _mid;
  String get mKey => _mKey;
  String get website => _website;
  String get url => _url;

  String getMap(double amount, String callbackUrl, String orderId) {
    return json.encode({
      'mid': mid,
      'key_secret': mKey,
      'website': website,
      'orderId': orderId,
      'amount': amount.toString(),
      'callbackUrl': callbackUrl,
      'custId': '122',
    });
  }

  Future<void> generateTxnToken(double amount, String orderId) async {
    final callBackUrl =
        'https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=$orderId';
    final body = getMap(amount, callBackUrl, orderId);

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {'Content-type': 'application/json'},
      );
      final txnToken = response.body;
      await initiateTransaction(orderId, amount, txnToken, callBackUrl);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> initiateTransaction(
    String orderId,
    double amount,
    String txnToken,
    String callBackUrl,
  ) async {
    try {
      await AllInOneSdk.startTransaction(
        mid,
        orderId,
        amount.toString(),
        txnToken,
        callBackUrl,
        false,
        false,
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}

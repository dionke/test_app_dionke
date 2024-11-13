import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_app_dionke/domain/models/currency.dart';
import 'package:test_app_dionke/domain/repository/currency_repository.dart';

const _address = 'https://api.currencylayer.com/';

const _accessKey = '23d3200106a1d90e0b8173ba256583e8';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final http.Client client = http.Client();

  CurrencyRepositoryImpl();

  @override
  Future<List<Currency>> getAllCurrencies() async {
    var url = Uri.parse('${_address}list');
    var queryParameters = {'access_key': _accessKey};
    url = url.replace(queryParameters: queryParameters);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true) {
          final symbolsMap = jsonResponse['currencies'] as Map<String, dynamic>;

          return symbolsMap.entries.map((entry) {
            final key = entry.key;
            final value = entry.value.toString();
            return Currency(code: key, title: value);
          }).toList();
        }
      }
      return [];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  @override
  Future<String> getCurrencyConvert({
    required String from,
    required String to,
    required String amount,
  }) async {
    var url = Uri.parse('${_address}convert');
    var queryParameters = {
      'access_key': _accessKey,
      'from': from.toString(),
      'to': to.toString(),
      'amount': amount.toString(),
    };
    url = url.replace(queryParameters: queryParameters);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true) {
          return (jsonResponse['result'] as double).toString();
        }
      }
      return '';
    } catch (e) {
      print(e.toString());
      return '';
    }
  }
}

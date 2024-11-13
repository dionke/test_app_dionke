import 'package:test_app_dionke/domain/models/currency.dart';

abstract class CurrencyRepository {
  Future<List<Currency>> getAllCurrencies();

  Future<String> getCurrencyConvert({
    required String from,
    required String to,
    required String amount,
  });
}

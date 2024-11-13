part of 'currency_bloc.dart';

@immutable
abstract class CurrencyEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CurrencyFetchedEvent extends CurrencyEvent {}

class CurrencySelectCodeEvent extends CurrencyEvent {
  final bool isFirstField;
  final Currency selectedCurrency;

  CurrencySelectCodeEvent({
    required this.isFirstField,
    required this.selectedCurrency,
  });

  @override
  List<Object> get props => [isFirstField, selectedCurrency];
}

class CurrencyConvertEvent extends CurrencyEvent {
  final bool isFirstField;
  final String amount;

  CurrencyConvertEvent({
    required this.isFirstField,
    required this.amount,
  });

  @override
  List<Object> get props => [isFirstField, amount];
}

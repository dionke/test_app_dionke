part of 'currency_bloc.dart';

@immutable
abstract class CurrencyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CurrencyInitialState extends CurrencyState {}

class CurrencyLoadingState extends CurrencyState {}

class CurrencyShowErrorState extends CurrencyState {
  final String errorText;
  final String errorBody;

  CurrencyShowErrorState({
    required this.errorText,
    required this.errorBody,
  });

  @override
  List<Object> get props => [errorText, errorBody];
}

class CurrencyLoadedState extends CurrencyState {
  final List<Currency> currencies;

  final String firstAmount;
  final Currency firstSelectedCurrency;

  final String secondAmount;
  final Currency secondSelectedCurrency;

  CurrencyLoadedState({
    this.currencies = const [],
    this.firstAmount = '',
    this.firstSelectedCurrency = emptyCurrency,
    this.secondAmount = '',
    this.secondSelectedCurrency = emptyCurrency,
  });

  @override
  List<Object?> get props => [
        currencies,
        firstAmount,
        firstSelectedCurrency,
        secondAmount,
        secondSelectedCurrency,
      ];

  CurrencyLoadedState copyWith({
    List<Currency>? currencies,
    String? firstAmount,
    Currency? firstSelectedCurrency,
    String? secondAmount,
    Currency? secondSelectedCurrency,
  }) {
    return CurrencyLoadedState(
      currencies: currencies ?? this.currencies,
      firstAmount: firstAmount ?? this.firstAmount,
      firstSelectedCurrency:
          firstSelectedCurrency ?? this.firstSelectedCurrency,
      secondAmount: secondAmount ?? this.secondAmount,
      secondSelectedCurrency:
          secondSelectedCurrency ?? this.secondSelectedCurrency,
    );
  }
}

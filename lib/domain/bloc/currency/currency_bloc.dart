import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:test_app_dionke/domain/models/currency.dart';
import 'package:test_app_dionke/domain/repository/currency_repository.dart';

part 'currency_event.dart';

part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyRepository _currencyRepository;

  CurrencyBloc(
    this._currencyRepository,
  ) : super(CurrencyInitialState()) {
    on<CurrencyFetchedEvent>(_onCurrencyFetched);
    on<CurrencySelectCodeEvent>(_onCurrencySelectCode);
    on<CurrencyConvertEvent>(_onCurrencyConvert);

    add(CurrencyFetchedEvent());
  }

  Future<void> _onCurrencyFetched(
    CurrencyFetchedEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(CurrencyLoadingState());
    try {
      final currencies = await _currencyRepository.getAllCurrencies();

      emit(CurrencyLoadedState(currencies: currencies));
    } catch (e) {
      emit(CurrencyShowErrorState(
          errorText: 'Empty list', errorBody: e.toString()));
      print(e.toString());
    }
  }

  Future<void> _onCurrencySelectCode(
    CurrencySelectCodeEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    final oldState = state;

    if (oldState is CurrencyLoadedState) {
      if (event.isFirstField) {
        emit(oldState.copyWith(firstSelectedCurrency: event.selectedCurrency));
      } else {
        emit(oldState.copyWith(secondSelectedCurrency: event.selectedCurrency));
      }
    }
  }

  Future<void> _onCurrencyConvert(
    CurrencyConvertEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    final oldState = state;

    if (oldState is CurrencyLoadedState) {
      try {
        if (event.isFirstField) {
          final amount = await _currencyRepository.getCurrencyConvert(
            from: oldState.firstSelectedCurrency.code,
            to: oldState.secondSelectedCurrency.code,
            amount: event.amount,
          );

          emit(oldState.copyWith(
              firstAmount: event.amount, secondAmount: amount));
        } else {
          final amount = await _currencyRepository.getCurrencyConvert(
            from: oldState.secondSelectedCurrency.code,
            to: oldState.firstSelectedCurrency.code,
            amount: event.amount,
          );

          emit(oldState.copyWith(
              firstAmount: amount, secondAmount: event.amount));
        }
      } catch (e) {
        emit(CurrencyShowErrorState(
            errorText: 'Error convert', errorBody: e.toString()));
        print(e.toString());
      }
    }
  }
}

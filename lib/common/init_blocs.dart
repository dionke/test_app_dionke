import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_dionke/domain/bloc/currency/currency_bloc.dart';

import 'sl.dart';

List<BlocProvider> initBlocs() {
  return [
    BlocProvider<CurrencyBloc>(lazy: false, create: (_) => sl<CurrencyBloc>()),
  ];
}

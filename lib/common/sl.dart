import 'package:get_it/get_it.dart';
import 'package:test_app_dionke/data/repository_impl/currency_repository_impl.dart';
import 'package:test_app_dionke/domain/bloc/currency/currency_bloc.dart';
import 'package:test_app_dionke/domain/repository/currency_repository.dart';

final sl = GetIt.instance;

Future<void> initSl() async {
  //BLOCS
  sl.registerLazySingleton(() => CurrencyBloc(sl()));

  //Repositories
  sl.registerLazySingleton<CurrencyRepository>(() => CurrencyRepositoryImpl());
}

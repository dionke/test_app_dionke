import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'common/init_blocs.dart';
import 'common/sl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initSl();

  runApp(
    MultiBlocProvider(
      providers: initBlocs(),
      child: App(),
    ),
  );
}

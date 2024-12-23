import 'package:flutter/material.dart';
import 'common/router/router.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(
        rebuildStackOnDeepLink: true,
        includePrefixMatches: true,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Currency converter',
    );
  }
}

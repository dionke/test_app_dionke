//ignore_for_file: public_member_api_docs
import 'package:auto_route/auto_route.dart';

import '../../presentation/currency_converter/currency_converter_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter implements AutoRouteGuard {
  AppRouter({super.navigatorKey});

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: CurrencyConverterRoute.page, path: '/'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next(true);
  }
}

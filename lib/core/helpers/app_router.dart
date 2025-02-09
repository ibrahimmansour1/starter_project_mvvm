import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/sign_in_view.dart';

class Routes {
  static const String home = '/';
  static const String signInView = '/signInView';
  static const String signUpView = '/signUpView';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => Container());
      case Routes.signInView:
        return MaterialPageRoute(builder: (_) => SignInView());
      case Routes.signUpView:
        return MaterialPageRoute(builder: (_) => Container());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}

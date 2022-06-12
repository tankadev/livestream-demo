import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hitalive/screens/screens.dart';

import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    print(args);

    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case Routes.login:
        return CupertinoPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case Routes.register:
        return CupertinoPageRoute(
          builder: (BuildContext context) => const RegisterScreen(),
        );

      case Routes.privates:
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const PrivatesScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery_application/core/screens/login/login_view.dart';
import 'package:food_delivery_application/core/screens/splash/splash_view.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.onboardingRoute:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Onboarding"))),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("No Route Found")),
        body: const Center(child: Text("No Route Found")),
      ),
    );
  }
}

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String onboardingRoute = "/onboarding";
  static const String mainRoute = "/main";
  static const String foodDetailsRoute = "/foodDetails";
  static const String forgotPasswordRoute = "/forgotPassword";
}

import 'package:flutter/material.dart';

import '../views/forgot_password/forgot_password_view.dart';
import '../views/home/home_view.dart';
import '../views/login/login_view.dart';
import '../views/main/main_view.dart';
import '../views/splash/splash_view.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());

      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
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
  static const String homeRoute = "/home";
}
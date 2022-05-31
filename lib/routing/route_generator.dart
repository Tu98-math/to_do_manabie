import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_manabie/page/home/home_page.dart';

import '/page/welcome/welcome_page.dart';
import 'app_routes.dart';

class RouteGenerator {
  static RouteGenerator? _instance;

  RouteGenerator._();

  factory RouteGenerator() {
    _instance ??= RouteGenerator._();
    return _instance!;
  }

  Route<dynamic> onGenerateRoute(RouteSettings setting) {
    GetPageRoute page({required Widget child}) {
      return GetPageRoute(
          settings: setting, page: () => child, transition: Transition.fadeIn);
    }

    switch (setting.name) {
      // case AppRoutes.WELCOME:
      //   return page(child: WelcomePage.instance());
      case AppRoutes.WELCOME:
        return page(child: WelcomePage.instance());
      case AppRoutes.HOME:
        return page(child: HomePage.instance());
      default:
        throw const RouteException("Route not found");
    }
  }
}

class RouteException implements Exception {
  final String message;

  const RouteException(this.message);
}

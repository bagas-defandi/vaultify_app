import 'package:flutter/material.dart';
import 'package:vaultify_app/pages/dashboard_page.dart';
import 'package:vaultify_app/pages/login_page.dart';

class AppRoutes {
  static const String dashboardPage = './dashboard_page,dart';
  static const String loginPage = './login_page.dart';

  static Map<String, WidgetBuilder> routes = {
    dashboardPage: (context) => const DashboardPage(),
    loginPage: (context) => const LoginPage(),
  };
}

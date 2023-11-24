import 'package:flutter/material.dart';
import 'package:vaultify_app/presentation/android_small_one_screen/android_small_one_screen.dart';

class AppRoutes {
  static const String androidSmallOneScreen = '/android_small_one_screen';

  static Map<String, WidgetBuilder> routes = {
    androidSmallOneScreen: (context) => AndroidSmallOneScreen()
  };
}

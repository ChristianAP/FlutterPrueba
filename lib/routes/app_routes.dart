import 'package:flutter/material.dart';
import 'package:flutter_app_carrito/src/pages/login_pages.dart';

class AppRoutes {
  static const initialRoute = LoginPage.routeName;

  static Map<String, Widget Function(BuildContext)> routes = {
    LoginPage.routeName: (_) => LoginPage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => LoginPage());
  }
}

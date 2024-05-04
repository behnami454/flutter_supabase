import 'package:flutter/material.dart';
import 'package:flutter_supabase/screens/login_page.dart';

import '../screens/home_page.dart';

class Routes {
  static const String routeLogin = "/startup";
  static const String routeHome = "/home";

  static final Map<String, WidgetBuilder> routes = {
    routeLogin: (context) => LoginPage(),
    routeHome: (context) => const HomePage(),
  };
}

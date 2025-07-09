import 'package:flutter/cupertino.dart';
import 'package:login_system/screen/view/Home/UI/home.dart';
import 'package:login_system/screen/view/Login/UI/login.dart';
import 'package:login_system/screen/view/Register/UI/register.dart';

class Routes {
  static const String loginRoute = '/';
  static const String registerRoute = '/register';
  static const String homepage = '/homepage';

  static Map<String, WidgetBuilder> routes = {
    loginRoute: (context) => Login(),
    registerRoute: (context) => Register(),
    homepage: (context) => Home(),
  };
}

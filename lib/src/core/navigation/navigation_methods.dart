import 'package:flutter/material.dart';
import 'package:mk/src/ui/pages/cart/cart_page.dart';
import 'package:mk/src/ui/pages/error_page/error_page.dart';
import 'package:mk/src/ui/pages/home/home_page.dart';
import 'package:mk/src/ui/pages/profile/profile_page.dart';
import 'package:mk/src/ui/pages/sign_in_with_email/sign_in_with_email_screen.dart';


class RouteMethods {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;
    switch (settings.name) {
      case Home.route:
        return _materialPageRoute(page: const Home(title: 'home'));
      case Profile.route:
        return _materialPageRoute(page: const Profile(), fullscreenDialog: true);
      case Cart.route:
        return _materialPageRoute(page: const Cart(), fullscreenDialog: true);
        case SignInWithEmail.route:
        return _materialPageRoute(page: const SignInWithEmail(), fullscreenDialog: true);
        case InternetCheck.route:
        return _materialPageRoute(page: const InternetCheck(), fullscreenDialog: true);
      default:
        return _materialPageRoute(page: const ErrorPage());
    }
  }

  static _materialPageRoute(
          {required Widget page, bool fullscreenDialog = false}) =>
      MaterialPageRoute(
          builder: (context) => page, fullscreenDialog: fullscreenDialog);
  static Future<Object?> navigateTo(
          {required BuildContext context, required String routeName, dynamic args}) async{
    Navigator.of(context).pushNamed(routeName, arguments: args);
    return null;
  }
}

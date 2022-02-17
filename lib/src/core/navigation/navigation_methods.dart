import 'package:flutter/material.dart';
import 'package:mk/src/ui/pages/cart/cart_page.dart';
import 'package:mk/src/ui/pages/error_page/error_page.dart';
import 'package:mk/src/ui/pages/home/home_page.dart';
import 'package:mk/src/ui/pages/otp_page/otp_page.dart';
import 'package:mk/src/ui/pages/profile/profile_page.dart';
import 'package:mk/src/ui/pages/provider_products_page/provider_products_page.dart';

import '../../ui/pages/profile/account_info.dart';
import '../../ui/pages/providers/providers_page.dart';
import '../../ui/pages/sign_in_with_email/email_sign_in_bloc.dart';
import '../../ui/pages/sign_in_with_email/sign_in_with_email_screen.dart';
import '../../ui/pages/stream_test_page/stream_test.dart';

class RouteMethods {
  // static AuthBase? auth = Auth();
  // RouteMethods() {
  //   auth = Auth();
  // }
  final SignInBloc signInBloc = SignInBloc();
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;
    switch (settings.name) {
      case Home.route:
        return _materialPageRoute(page: const Home(title: 'home'));
      case Profile.route:
        return _materialPageRoute(
            page: const Profile(), fullscreenDialog: true);
      case Cart.route:
        return _materialPageRoute(page: const Cart(), fullscreenDialog: true);
      case SignInWithEmailAndPhone.route:
        return _materialPageRoute(
            page: SignInWithEmailAndPhone());
      // case UserStatus.route:
      //   return _materialPageRoute(
      //       page: const UserStatus());
      case ProvidersPage.route:
        return _materialPageRoute(
          page: const ProvidersPage(),
        );
        // case LandingPage.route:
        // return _materialPageRoute(
        //   page: const LandingPage(),
        // );
      case AccountInfo.route:
        return _materialPageRoute(page: const AccountInfo());
        case StreamTestPage.route:
        return _materialPageRoute(page: const StreamTestPage());
      case OTPPage.route:
        return _materialPageRoute(page: OTPPage(phoneNumber: args));
        case ProviderProductsPage.route:
        return _materialPageRoute(page: const ProviderProductsPage());
      default:
        return _materialPageRoute(page: const ErrorPage());
    }
  }

  static _materialPageRoute(
          {required Widget page, bool fullscreenDialog = false}) =>
      MaterialPageRoute(
          builder: (context) => page, fullscreenDialog: fullscreenDialog);
  static Future<Object?> navigateTo(
      {required BuildContext context,
      required String routeName,
      dynamic args}) async {
    Navigator.of(context).pushNamed(routeName, arguments: args);
    return null;
  }

  static Future<Object?> navigateAndChange(
      {required BuildContext context,
      required String routeName,
      dynamic args}) async {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: args);
    return null;
  }
}

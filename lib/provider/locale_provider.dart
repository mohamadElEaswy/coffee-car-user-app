import 'dart:ui';
import 'package:mk/l10n/l10n.dart';
import 'package:mk/src/database/local/local_db.dart';
import 'package:mk/src/database/local/local_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';


class LocaleProvider extends ChangeNotifier {
//get the previous language from local DB "shared preferences" or use 'en' english language
  Locale _locale = Locale(LocalDatabase().getLocalLang() ?? 'en');

  Locale get locale => _locale;
//change language method
  void setLocale(Locale locale) async{
    if (!L10n.all.contains(locale)) {
      return null;
    }
    await LocalDBServices.setLocalString(value: locale.languageCode, key: 'language_code');
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('en');
    notifyListeners();
  }

  Future<Locale> getLocaleData() async {
    var prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    if (languageCode  == null) {
      return window.locale;
    } else {
      return Locale(languageCode);
    }
  }
}

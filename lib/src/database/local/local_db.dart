import 'dart:ui';

import 'package:mk/src/database/local/local_sevices.dart';

abstract class LocalDB {
  String? getLocalLang();
}

class LocalDatabase implements LocalDB {

  @override
  String? getLocalLang() {
    String? languageCode =
         LocalDBServices.getLocalString(key: 'language_code');

    if (languageCode == null) {
      return window.locale.languageCode;
    } else {
      return languageCode;
    }
  }



}

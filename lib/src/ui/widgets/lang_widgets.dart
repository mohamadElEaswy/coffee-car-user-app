import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/l10n.dart';
import '../../../provider/locale_provider.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final flag = L10n.getFlag(locale.languageCode);

    return Center(
      child: CircleAvatar(
        child: Text(
          flag,
          style: const TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}



class LanguagePickerWidget extends StatelessWidget {
  const LanguagePickerWidget({Key? key, required this.width}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;

    return
      // DropdownButtonHideUnderline(
      // child:
      DropdownButton(
        // disabledHint: Text('choose language'),
        value: locale,
        // hint: const Text('Change language', style: TextStyle(color: Colors.black)),
        // icon: const Icon(Icons.arrow_downward,color: Colors.black),
        items: L10n.all.map(
              (locale) {
            final flag = L10n.getFlag(locale.languageCode);
            final String lang = locale.languageCode.toUpperCase();
            return DropdownMenuItem(
              child: SizedBox(
                width: width,
                child: Text(
                  // flag +'  '+
                      lang == 'EN' ? 'English' : 'العربية',
                  // style: const TextStyle(fontSize: 26),
                ),
              ),
              value: locale,
              onTap: () {
                final provider =
                Provider.of<LocaleProvider>(context, listen: false);

                provider.setLocale(locale);
              },
            );
          },
        ).toList(),
        onChanged: (_) {},
      // ),
    );
  }
}
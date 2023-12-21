import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants.dart';
import '../main.dart';
import 'ButtonWithIcon.dart';

class LangaugeDialog {
  Future<void> languageSelectionDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.chooseLanguage),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ButtonWithIcon(
                    english, const AssetImage("assets/images/english.png"),
                    () async {
                  await updateLocale(const Locale('en'), context);
                }),
                ButtonWithIcon(
                    swedish, const AssetImage("assets/images/sweden.png"),
                    () async {
                  await updateLocale(const Locale('sv'), context);
                }),
                ButtonWithIcon(
                    danish, const AssetImage("assets/images/denmark.png"),
                    () async {
                  await updateLocale(const Locale('da'), context);
                }),
                ButtonWithIcon(
                    german, const AssetImage("assets/images/germany.png"),
                        () async {
                      await updateLocale(const Locale('de'), context);
                    }),
                ButtonWithIcon(
                    arabic, const AssetImage("assets/images/iraq.png"),
                    () async {
                  await updateLocale(const Locale('ar'), context);
                }),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

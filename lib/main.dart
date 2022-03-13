import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mandaean_calendar_2022/ButtonWithIcon.dart';
import 'package:mandaean_calendar_2022/Constants.dart' as constants;

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Exploration',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(primarySwatch: Colors.blue),
            home: MyHomePage(),
        );
    }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      drawer: Drawer(
          child: ListView(
              padding: const EdgeInsets.symmetric(
                  vertical: 60.0,
                  horizontal: 20.0,
              ),
              children: [
                  ButtonWithIcon(
                      AppLocalizations.of(context)!.language, const AssetImage("assets/images/ic_menu_language.png"),
                          () {
                          Navigator.pop(context);
                          _showMyDialog(context);
                      }),
                  ButtonWithIcon(
                      AppLocalizations.of(context)!.about, const AssetImage("assets/images/ic_menu_about.png"),
                          () {
                          Navigator.pop(context);
                      }),
      ])),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
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
                                constants.english, const AssetImage("assets/images/english.png"),
                                    () {
                                    Navigator.pop(context);
                                }),
                            ButtonWithIcon(
                                constants.swedish, const AssetImage("assets/images/sweden.png"),
                                    () {
                                    Navigator.pop(context);
                                }),
                            ButtonWithIcon(
                                constants.danish, const AssetImage("assets/images/denmark.png"),
                                    () {
                                    Navigator.pop(context);
                                }),
                            ButtonWithIcon(
                                constants.arabic, const AssetImage("assets/images/iraq.png"),
                                    () {
                                    Navigator.pop(context);
                                }),
                            ButtonWithIcon(
                                constants.mandaeanic, const AssetImage("assets/images/mandaeanic.png"),
                                    () {
                                    Navigator.pop(context);
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

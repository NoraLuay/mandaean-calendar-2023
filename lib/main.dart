import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mandaean_calendar_2022/DrawerButton.dart';

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
                  DrawerButton(
                      AppLocalizations.of(context)!.notification, const AssetImage("assets/images/ic_menu_notification.png"),
                          () {
                          Navigator.pop(context);
                      }),
                  DrawerButton(
                      AppLocalizations.of(context)!.language, const AssetImage("assets/images/ic_menu_language.png"),
                          () {
                          Navigator.pop(context);
                      }),
                  DrawerButton(
                      AppLocalizations.of(context)!.about, const AssetImage("assets/images/ic_menu_about.png"),
                          () {
                          Navigator.pop(context);
                      }),
      ])),
    );
  }
}

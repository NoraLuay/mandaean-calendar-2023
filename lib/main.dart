import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mandaean_calendar_2022/ButtonWithIcon.dart';
import 'package:mandaean_calendar_2022/Constants.dart' as constants;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Exploration',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      var languageCode = prefs.getString(constants.languageKey);
      if (languageCode != null) {
        Get.updateLocale(Locale(languageCode));
      } else {
        Get.updateLocale(const Locale('en'));
        _showLanguageSelectionDialog(context);
      }
    });
  }

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
            ButtonWithIcon(AppLocalizations.of(context)!.language,
                const AssetImage("assets/images/ic_menu_language.png"), () {
              Navigator.pop(context);
              _showLanguageSelectionDialog(context);
            }),
            ButtonWithIcon(AppLocalizations.of(context)!.about,
                const AssetImage("assets/images/ic_menu_about.png"), () {
              Navigator.pop(context);
              _showAboutDialog(context);
            }),
          ])),
    );
  }
}

Future<void> _showLanguageSelectionDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.chooseLanguage),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ButtonWithIcon(constants.english,
                  const AssetImage("assets/images/english.png"), () async {
                    await updateLocale(const Locale('en'), context);
                  }),
              ButtonWithIcon(constants.swedish,
                  const AssetImage("assets/images/sweden.png"), () async {
                    await updateLocale(const Locale('sv'), context);
                  }),
              ButtonWithIcon(constants.danish,
                  const AssetImage("assets/images/denmark.png"), () async {
                    await updateLocale(const Locale('da'), context);
                  }),
              ButtonWithIcon(
                  constants.arabic, const AssetImage("assets/images/iraq.png"),
                      () async {
                    await updateLocale(const Locale('ar'), context);
                  }),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> _showAboutDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.about),
        content: Text(AppLocalizations.of(context)!.aboutDescription),
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

Future<void> updateLocale(Locale locale, BuildContext context) async {
  Get.updateLocale(locale);

  final prefs = await SharedPreferences.getInstance();
  prefs.setString(constants.languageKey, locale.languageCode);

  Navigator.pop(context);
}

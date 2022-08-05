import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mandaean_calendar_2022/components/ButtonWithIcon.dart';
import 'package:mandaean_calendar_2022/Constants.dart' as constants;
import 'package:get/get.dart';
import 'package:mandaean_calendar_2022/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/events_example.dart';
import 'constants.dart';
import 'components/date_legend.dart';

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
      Map<DateTime, List<Event>> calendarEvents = loadCalendarEvents(context);
      events.clear();
      events.addAll(calendarEvents);
      
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
            const SizedBox(height: 24.0),
            Text(AppLocalizations.of(context)!.colorsDescription, style: const TextStyle(fontSize: 16.0)),
                  const Divider(
                      color: Colors.black,
                      height: 12,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                  ),
                  DateLegend(AppLocalizations.of(context)!.religiousOccasion, colorReligiousOccasion),
                  DateLegend(AppLocalizations.of(context)!.beginningOfTheMonth, colorBeginningOfTheMonth),
                  DateLegend(AppLocalizations.of(context)!.lightDayOfFasting, colorLightDayOfFasting),
                  DateLegend(AppLocalizations.of(context)!.heavyDayOfFasting, colorHeavyDayOfFasting),
          ])),
        // body: MyTableCalendar(calendarEvents()),
        body: TableEventsExample(calendarEvents: calendarEvents),
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
    barrierDismissible: true,
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

Map<DateTime, List<Event>> loadCalendarEvents(BuildContext context) {
  final eve = {
    // Jan
    DateTime.utc(2022, 1, 6): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 1, 14): [
      Event(const Color(0xFF3264FF),
          AppLocalizations.of(context)!.calendar_beginning_of_month_01)
    ],

    // Feb
    DateTime.utc(2022, 2, 13): [
      Event(const Color(0xFF3264FF),
          AppLocalizations.of(context)!.calendar_beginning_of_month_02)
    ],

    // Mar
    DateTime.utc(2022, 3, 9): [
      Event(const Color(0xFFFF0000),
          AppLocalizations.of(context)!.heavyDayOfFasting)
    ],
    DateTime.utc(2022, 3, 10): [
      Event(const Color(0xFFFF0000),
          AppLocalizations.of(context)!.heavyDayOfFasting)
    ],
    DateTime.utc(2022, 3, 11): [
      Event(const Color(0xFFFF0000),
          AppLocalizations.of(context)!.heavyDayOfFasting)
    ],
    DateTime.utc(2022, 3, 12): [
      Event(const Color(0xFFFF0000),
          AppLocalizations.of(context)!.heavyDayOfFasting)
    ],
    DateTime.utc(2022, 3, 13): [
      Event(const Color(0xFFFF0000),
          AppLocalizations.of(context)!.heavyDayOfFasting)
    ],

    DateTime.utc(2022, 3, 14): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_banja_day_1)
    ],
    DateTime.utc(2022, 3, 15): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_banja_day_2)
    ],
    DateTime.utc(2022, 3, 16): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_banja_day_3)
    ],
    DateTime.utc(2022, 3, 17): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_banja_day_4)
    ],
    DateTime.utc(2022, 3, 18): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_banja_day_5)
    ],
    DateTime.utc(2022, 3, 19): [
      Event(const Color(0xFF3264FF),
          AppLocalizations.of(context)!.calendar_beginning_of_month_03),
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],

    // Apr
    DateTime.utc(2022, 4, 18): [
      Event(const Color(0xFF3264FF),
          AppLocalizations.of(context)!.calendar_beginning_of_month_04)
    ],

    // May
    DateTime.utc(2022, 5, 18): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_dehbaAdDemana),
      Event(const Color(0xFF3264FF),
          AppLocalizations.of(context)!.calendar_beginning_of_month_05)
    ],
    DateTime.utc(2022, 5, 19): [
      Event(const Color(0xFFFF0000),
          AppLocalizations.of(context)!.heavyDayOfFasting)
    ],

    // Jun
    DateTime.utc(2022, 6, 17): [
      Event(const Color(0xFF3264FF),
          AppLocalizations.of(context)!.calendar_beginning_of_month_06)
    ],

    // Jul
    DateTime.utc(2022, 7, 14): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 7, 15): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 7, 16): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_kenshiWeZehli)
    ],
    DateTime.utc(2022, 7, 17): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_dehbaAdRaba_1),
      Event(const Color(0xFF3264FF),
          AppLocalizations.of(context)!.calendar_beginning_of_month_07),
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 7, 18): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_dehbaAdRaba_2),
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 7, 19): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 7, 20): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 7, 21): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 7, 22): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_aiedShoshian_1),
      Event(const Color(0xFFFF0000),
          AppLocalizations.of(context)!.heavyDayOfFasting)
    ],
    DateTime.utc(2022, 7, 23): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_aiedShoshian_2),
      Event(const Color(0xFFFF0000),
          AppLocalizations.of(context)!.heavyDayOfFasting)
    ],
    DateTime.utc(2022, 7, 24): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 7, 25): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 7, 26): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 7, 27): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 7, 28): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 7, 29): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 7, 30): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 7, 31): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_yomIlTihare)
    ],

    // Aug
    DateTime.utc(2022, 8, 7): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 8, 16): [
      Event(const Color(0xFF3264FF),
          AppLocalizations.of(context)!.calendar_beginning_of_month_08)
    ],

    // Sep
    DateTime.utc(2022, 9, 9): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 9, 15): [
      Event(const Color(0xFF3264FF),
          AppLocalizations.of(context)!.calendar_beginning_of_month_09)
    ],

    // Oct
    DateTime.utc(2022, 10, 15): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_degIlFil),
      Event(const Color(0xFF3264FF),
          AppLocalizations.of(context)!.calendar_beginning_of_month_10),
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 10, 16): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 10, 17): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 10, 18): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],

    // Nov
    DateTime.utc(2022, 11, 1): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_dehbaAdHanena)
    ],
    DateTime.utc(2022, 11, 14): [
      Event(const Color(0xFF3264FF),
          AppLocalizations.of(context)!.calendar_beginning_of_month_11)
    ],

    // Dec
    DateTime.utc(2022, 12, 14): [
      Event(const Color(0xFF14C815),
          AppLocalizations.of(context)!.calendar_event_yomIlTihare),
      Event(const Color(0xFF3264FF),
          AppLocalizations.of(context)!.calendar_beginning_of_month_12)
    ],
    DateTime.utc(2022, 12, 22): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
    DateTime.utc(2022, 12, 28): [
      Event(const Color(0xFFFFC800),
          AppLocalizations.of(context)!.lightDayOfFasting)
    ],
  };

  return eve;
}

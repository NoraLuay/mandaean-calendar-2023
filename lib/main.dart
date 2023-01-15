import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mandaean_calendar_2022/components/ButtonWithIcon.dart';
import 'package:get/get.dart';
import 'package:mandaean_calendar_2022/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/calendar_events.dart';
import 'constants.dart';
import 'components/date_legend.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
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

var calendar = const CalendarEvents();

class _MyHomePage extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      var languageCode = prefs.getString(languageKey);
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
    loadCalendarEvents(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
          backgroundColor: primaryColor,
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
            Text(AppLocalizations.of(context)!.eventFilterHeader,
                style: const TextStyle(fontSize: 16.0)),
            const Divider(
              color: Colors.black,
              height: 12,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            DateLegend(AppLocalizations.of(context)!.religiousOccasion,
                colorReligiousOccasion, (isSwitched) {
              saveEventToggle(religiousOccasionKey, isSwitched);
              loadCalendarEvents(context);
            }),
            DateLegend(AppLocalizations.of(context)!.beginningOfTheMonth,
                colorBeginningOfTheMonth, (isSwitched) {
              saveEventToggle(beginningOfTheMonthKey, isSwitched);
              loadCalendarEvents(context);
            }),
            DateLegend(AppLocalizations.of(context)!.lightDayOfFasting,
                colorLightDayOfFasting, (isSwitched) {
              saveEventToggle(lightDayOfFastingKey, isSwitched);
              loadCalendarEvents(context);
            }),
            DateLegend(AppLocalizations.of(context)!.heavyDayOfFasting,
                colorHeavyDayOfFasting, (isSwitched) {
              saveEventToggle(heavyDayOfFastingKey, isSwitched);
              loadCalendarEvents(context);
            }),
            DateLegend(AppLocalizations.of(context)!.peopleOfInterests,
                colorPeopleOfInterest, (isSwitched) {
              saveEventToggle(peopleOfInterestKey, isSwitched);
              loadCalendarEvents(context);
            }),
          ])),
      // body: MyTableCalendar(calendarEvents()),
      body: calendar,
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
              ButtonWithIcon(arabic, const AssetImage("assets/images/iraq.png"),
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
  prefs.setString(languageKey, locale.languageCode);

  Navigator.pop(context);
}

Future<void> saveEventToggle(String eventKey, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(eventKey, value);
}

Future<void> loadCalendarEvents(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  bool showReligiousOccasion = prefs.getBool(religiousOccasionKey) ?? true;
  bool showBeginningOfMonth = prefs.getBool(beginningOfTheMonthKey) ?? true;
  bool showLightDayOfFasting = prefs.getBool(lightDayOfFastingKey) ?? true;
  bool showHeavyDayOfFasting = prefs.getBool(heavyDayOfFastingKey) ?? true;
  bool showPeopleOfInterest = prefs.getBool(peopleOfInterestKey) ?? true;

  events.clear();

  final eventsInternal = {
    // Jan
    DateTime.utc(2023, 1, 5): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 1, 13): [
      Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
          AppLocalizations.of(context)!.calendar_beginning_of_month_01)
    ],
    DateTime.utc(2023, 1, 18): [
      Event(showPeopleOfInterest, const Color(colorPeopleOfInterest),
          AppLocalizations.of(context)!.calendar_people_of_interests_01)
    ],

    // Feb
    DateTime.utc(2023, 2, 12): [
      Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
          AppLocalizations.of(context)!.calendar_beginning_of_month_02)
    ],

    // Mar
    DateTime.utc(2023, 3, 4): [
      Event(showPeopleOfInterest, const Color(colorPeopleOfInterest),
          AppLocalizations.of(context)!.calendar_people_of_interests_02)
    ],
    DateTime.utc(2023, 3, 9): [
      Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
          AppLocalizations.of(context)!.calendar_heavy_fasting)
    ],
    DateTime.utc(2023, 3, 10): [
      Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
          AppLocalizations.of(context)!.calendar_heavy_fasting)
    ],
    DateTime.utc(2023, 3, 11): [
      Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
          AppLocalizations.of(context)!.calendar_heavy_fasting)
    ],
    DateTime.utc(2023, 3, 12): [
      Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
          AppLocalizations.of(context)!.calendar_heavy_fasting)
    ],
    DateTime.utc(2023, 3, 13): [
      Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
          AppLocalizations.of(context)!.calendar_heavy_fasting)
    ],

    DateTime.utc(2023, 3, 14): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_banja_day_1)
    ],
    DateTime.utc(2023, 3, 15): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_banja_day_2)
    ],
    DateTime.utc(2023, 3, 16): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_banja_day_3)
    ],
    DateTime.utc(2023, 3, 17): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_banja_day_4)
    ],
    DateTime.utc(2023, 3, 18): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_banja_day_5)
    ],
    DateTime.utc(2023, 3, 19): [
      Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
          AppLocalizations.of(context)!.calendar_beginning_of_month_03),
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],

    // Apr
    DateTime.utc(2023, 4, 18): [
      Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
          AppLocalizations.of(context)!.calendar_beginning_of_month_04)
    ],

    // May
    DateTime.utc(2023, 5, 18): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_dehbaAdDemana),
      Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
          AppLocalizations.of(context)!.calendar_beginning_of_month_05)
    ],
    DateTime.utc(2023, 5, 19): [
      Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
          AppLocalizations.of(context)!.calendar_heavy_fasting)
    ],

    // Jun
    DateTime.utc(2023, 6, 17): [
      Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
          AppLocalizations.of(context)!.calendar_beginning_of_month_06)
    ],
    DateTime.utc(2023, 6, 24): [
      Event(showPeopleOfInterest, const Color(colorPeopleOfInterest),
          AppLocalizations.of(context)!.calendar_people_of_interests_03)
    ],

    // Jul
    DateTime.utc(2023, 7, 9): [
      Event(showPeopleOfInterest, const Color(colorPeopleOfInterest),
          AppLocalizations.of(context)!.calendar_people_of_interests_04)
    ],
    DateTime.utc(2023, 7, 14): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 7, 15): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 7, 16): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_kenshiWeZehli)
    ],
    DateTime.utc(2023, 7, 17): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_dehbaAdRaba_1),
      Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
          AppLocalizations.of(context)!.calendar_beginning_of_month_07),
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 7, 18): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_dehbaAdRaba_2),
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 7, 19): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 7, 20): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 7, 21): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 7, 22): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_aiedShoshian_1),
      Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
          AppLocalizations.of(context)!.calendar_heavy_fasting)
    ],
    DateTime.utc(2023, 7, 23): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_aiedShoshian_2),
      Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
          AppLocalizations.of(context)!.calendar_heavy_fasting)
    ],
    DateTime.utc(2023, 7, 24): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 7, 25): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 7, 26): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 7, 27): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 7, 28): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 7, 29): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 7, 30): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 7, 31): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_yomIlTihare)
    ],

    // Aug
    DateTime.utc(2023, 8, 7): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 8, 16): [
      Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
          AppLocalizations.of(context)!.calendar_beginning_of_month_08)
    ],

    // Sep
    DateTime.utc(2023, 9, 9): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 9, 15): [
      Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
          AppLocalizations.of(context)!.calendar_beginning_of_month_09)
    ],

    // Oct
    DateTime.utc(2023, 10, 15): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_degIlFil),
      Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
          AppLocalizations.of(context)!.calendar_beginning_of_month_10),
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 10, 16): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 10, 17): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 10, 18): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],

    // Nov
    DateTime.utc(2023, 11, 1): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_dehbaAdHanena)
    ],
    DateTime.utc(2023, 11, 14): [
      Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
          AppLocalizations.of(context)!.calendar_beginning_of_month_11)
    ],
    DateTime.utc(2023, 11, 18): [
      Event(showPeopleOfInterest, const Color(colorPeopleOfInterest),
          AppLocalizations.of(context)!.calendar_people_of_interests_05)
    ],

    // Dec
    DateTime.utc(2023, 12, 14): [
      Event(showReligiousOccasion, const Color(colorReligiousOccasion),
          AppLocalizations.of(context)!.calendar_event_abuAlhiris),
      Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
          AppLocalizations.of(context)!.calendar_beginning_of_month_12)
    ],
    DateTime.utc(2023, 12, 22): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting)
    ],
    DateTime.utc(2023, 12, 28): [
      Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
          AppLocalizations.of(context)!.calendar_light_fasting),
      Event(showPeopleOfInterest, const Color(colorPeopleOfInterest),
          AppLocalizations.of(context)!.calendar_people_of_interests_06)
    ],
  };

  events.addAll(eventsInternal);
  calendar.refreshCalendar();
}

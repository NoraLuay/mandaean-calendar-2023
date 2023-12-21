import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mandaean_calendar_2022/components/ButtonWithIcon.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/calendar_events.dart';
import 'components/load_calender_events.dart';
import 'components/language_dialog.dart';
import 'components/show_about_dialog.dart';
import 'components/update_dialog.dart';
import 'constants.dart';
import 'components/date_legend.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const MyApp()));
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
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => UpdateDialog().showUpdateDialogIfAppNeedsUpdate(context));
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      var languageCode = prefs.getString(languageKey);
      if (languageCode != null) {
        Get.updateLocale(Locale(languageCode));
      } else {
        Get.updateLocale(const Locale('en'));
        LangaugeDialog().languageSelectionDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    LoadCalendarEvents().loadCalendarEvents(context);
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
              LangaugeDialog().languageSelectionDialog(context);
            }),
            ButtonWithIcon(AppLocalizations.of(context)!.about,
                const AssetImage("assets/images/ic_menu_about.png"), () {
              Navigator.pop(context);
              ShowAboutDialog().aboutDialog(context);
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
              LoadCalendarEvents().loadCalendarEvents(context);
            }),
            DateLegend(AppLocalizations.of(context)!.beginningOfTheMonth,
                colorBeginningOfTheMonth, (isSwitched) {
              saveEventToggle(beginningOfTheMonthKey, isSwitched);
              LoadCalendarEvents().loadCalendarEvents(context);
            }),
            DateLegend(AppLocalizations.of(context)!.lightDayOfFasting,
                colorLightDayOfFasting, (isSwitched) {
              saveEventToggle(lightDayOfFastingKey, isSwitched);
              LoadCalendarEvents().loadCalendarEvents(context);
            }),
            DateLegend(AppLocalizations.of(context)!.heavyDayOfFasting,
                colorHeavyDayOfFasting, (isSwitched) {
              saveEventToggle(heavyDayOfFastingKey, isSwitched);
              LoadCalendarEvents().loadCalendarEvents(context);
            }),
            DateLegend(AppLocalizations.of(context)!.predictionDay,
                colorPredictionDay, (isSwitched) {
              saveEventToggle(predictionDayKey, isSwitched);
              LoadCalendarEvents().loadCalendarEvents(context);
            }),
            DateLegend(AppLocalizations.of(context)!.disappearanceOfMoon,
                colorDisappearanceOfMoon, (isSwitched) {
              saveEventToggle(disappearanceOfMoonKey, isSwitched);
              LoadCalendarEvents().loadCalendarEvents(context);
            }),
            DateLegend(AppLocalizations.of(context)!.peopleOfInterests,
                colorPeopleOfInterest, (isSwitched) {
              saveEventToggle(peopleOfInterestKey, isSwitched);
              LoadCalendarEvents().loadCalendarEvents(context);
            }),
          ])),
      // body: MyTableCalendar(calendarEvents()),
      body: calendar,
    );
  }
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

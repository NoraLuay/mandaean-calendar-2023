import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../utils.dart';
import 'calendar_events.dart';

class LoadCalendarEvents {
  var calendar = const CalendarEvents();

  Future<void> loadCalendarEvents(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    bool showReligiousOccasion = prefs.getBool(religiousOccasionKey) ?? true;
    bool showBeginningOfMonth = prefs.getBool(beginningOfTheMonthKey) ?? true;
    bool showLightDayOfFasting = prefs.getBool(lightDayOfFastingKey) ?? true;
    bool showHeavyDayOfFasting = prefs.getBool(heavyDayOfFastingKey) ?? true;
    bool showPeopleOfInterest = prefs.getBool(peopleOfInterestKey) ?? true;
    bool showPredictionDay = prefs.getBool(predictionDayKey) ?? true;
    bool showLunarEclipse = prefs.getBool(lunarEclipseKey) ?? true;

    events.clear();

    final eventsInternal = {
      // Jan
      DateTime.utc(2024, 1, 5): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 1, 13): [
        Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
            AppLocalizations.of(context)!.calendar_beginning_of_month_01)
      ],
      DateTime.utc(2024, 1, 18): [
        Event(showPeopleOfInterest, const Color(colorPeopleOfInterest),
            AppLocalizations.of(context)!.calendar_people_of_interests_01)
      ],

      // Feb
      DateTime.utc(2024, 2, 10): [
        Event(showLunarEclipse, const Color(colorLunarEclipse),
            AppLocalizations.of(context)!.lunarEclipse)
      ],
      DateTime.utc(2024, 2, 12): [
        Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
            AppLocalizations.of(context)!.calendar_beginning_of_month_02)
      ],

      // Mar
      DateTime.utc(2024, 3, 4): [
        Event(showPeopleOfInterest, const Color(colorPeopleOfInterest),
            AppLocalizations.of(context)!.calendar_people_of_interests_02)
      ],
      DateTime.utc(2024, 3, 8): [
        Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
            AppLocalizations.of(context)!.calendar_heavy_fasting)
      ],
      DateTime.utc(2024, 3, 9): [
        Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
            AppLocalizations.of(context)!.calendar_heavy_fasting)
      ],
      DateTime.utc(2024, 3, 10): [
        Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
            AppLocalizations.of(context)!.calendar_heavy_fasting),
        Event(showLunarEclipse, const Color(colorLunarEclipse),
            AppLocalizations.of(context)!.lunarEclipse)
      ],
      DateTime.utc(2024, 3, 11): [
        Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
            AppLocalizations.of(context)!.calendar_heavy_fasting),
        Event(showPredictionDay, const Color(colorPredictionDay),
            AppLocalizations.of(context)!.predictionDay)
      ],
      DateTime.utc(2024, 3, 12): [
        Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
            AppLocalizations.of(context)!.calendar_heavy_fasting)
      ],
      DateTime.utc(2024, 3, 13): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_banja_day_1)
      ],
      DateTime.utc(2024, 3, 14): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_banja_day_2)
      ],
      DateTime.utc(2024, 3, 15): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_banja_day_3)
      ],
      DateTime.utc(2024, 3, 16): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_banja_day_4)
      ],
      DateTime.utc(2024, 3, 17): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_banja_day_5)
      ],
      DateTime.utc(2024, 3, 18): [
        Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
            AppLocalizations.of(context)!.calendar_beginning_of_month_03),
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],

      // Apr
      DateTime.utc(2024, 4, 8): [
        Event(showLunarEclipse, const Color(colorLunarEclipse),
            AppLocalizations.of(context)!.lunarEclipse)
      ],
      DateTime.utc(2024, 4, 10): [
        Event(showPredictionDay, const Color(colorPredictionDay),
            AppLocalizations.of(context)!.predictionDay)
      ],
      DateTime.utc(2024, 4, 17): [
        Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
            AppLocalizations.of(context)!.calendar_beginning_of_month_04)
      ],

      // May
      DateTime.utc(2024, 5, 8): [
        Event(showLunarEclipse, const Color(colorLunarEclipse),
            AppLocalizations.of(context)!.lunarEclipse)
      ],
      DateTime.utc(2024, 5, 17): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_dehbaAdDemana),
        Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
            AppLocalizations.of(context)!.calendar_beginning_of_month_05)
      ],
      DateTime.utc(2024, 5, 18): [
        Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
            AppLocalizations.of(context)!.calendar_heavy_fasting)
      ],

      // Jun
      DateTime.utc(2024, 6, 6): [
        Event(showLunarEclipse, const Color(colorLunarEclipse),
            AppLocalizations.of(context)!.lunarEclipse)
      ],
      DateTime.utc(2024, 6, 15): [
        Event(showPredictionDay, const Color(colorPredictionDay),
            AppLocalizations.of(context)!.predictionDay)
      ],
      DateTime.utc(2024, 6, 16): [
        Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
            AppLocalizations.of(context)!.calendar_beginning_of_month_06),
        Event(showPredictionDay, const Color(colorPredictionDay),
            AppLocalizations.of(context)!.predictionDay)
      ],
      DateTime.utc(2024, 6, 24): [
        Event(showPeopleOfInterest, const Color(colorPeopleOfInterest),
            AppLocalizations.of(context)!.calendar_people_of_interests_03)
      ],

      // Jul
      DateTime.utc(2024, 7, 6): [
        Event(showLunarEclipse, const Color(colorLunarEclipse),
            AppLocalizations.of(context)!.lunarEclipse)
      ],
      DateTime.utc(2024, 7, 9): [
        Event(showPeopleOfInterest, const Color(colorPeopleOfInterest),
            AppLocalizations.of(context)!.calendar_people_of_interests_04)
      ],
      DateTime.utc(2024, 7, 13): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 7, 14): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 7, 15): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_kenshiWeZehli)
      ],
      DateTime.utc(2024, 7, 16): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_dehbaAdRaba_1),
        Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
            AppLocalizations.of(context)!.calendar_beginning_of_month_07),
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 7, 17): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_dehbaAdRaba_2),
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 7, 18): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 7, 19): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 7, 20): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 7, 21): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_aiedShoshian_1),
        Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
            AppLocalizations.of(context)!.calendar_heavy_fasting)
      ],
      DateTime.utc(2024, 7, 22): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_aiedShoshian_2),
        Event(showHeavyDayOfFasting, const Color(colorHeavyDayOfFasting),
            AppLocalizations.of(context)!.calendar_heavy_fasting)
      ],
      DateTime.utc(2023, 7, 23): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 7, 24): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 7, 25): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 7, 26): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 7, 27): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 7, 28): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 7, 29): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 7, 30): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_yomIlTihare)
      ],

      // Aug
      DateTime.utc(2024, 8, 4): [
        Event(showLunarEclipse, const Color(colorLunarEclipse),
            AppLocalizations.of(context)!.lunarEclipse)
      ],
      DateTime.utc(2024, 8, 6): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 8, 15): [
        Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
            AppLocalizations.of(context)!.calendar_beginning_of_month_08)
      ],

      // Sep
      DateTime.utc(2024, 9, 3): [
        Event(showLunarEclipse, const Color(colorLunarEclipse),
            AppLocalizations.of(context)!.lunarEclipse)
      ],
      DateTime.utc(2024, 9, 8): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 9, 13): [
        Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
            AppLocalizations.of(context)!.calendar_beginning_of_month_09)
      ],

      // Oct
      DateTime.utc(2024, 10, 2): [
        Event(showLunarEclipse, const Color(colorLunarEclipse),
            AppLocalizations.of(context)!.lunarEclipse)
      ],
      DateTime.utc(2024, 10, 14): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_degIlFil),
        Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
            AppLocalizations.of(context)!.calendar_beginning_of_month_10),
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 10, 15): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 10, 16): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 10, 17): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 10, 31): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_dehbaAdHanena)
      ],

      // Nov
      DateTime.utc(2024, 11, 1): [
        Event(showLunarEclipse, const Color(colorLunarEclipse),
            AppLocalizations.of(context)!.lunarEclipse)
      ],
      DateTime.utc(2024, 11, 13): [
        Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
            AppLocalizations.of(context)!.calendar_beginning_of_month_11)
      ],
      DateTime.utc(2024, 11, 18): [
        Event(showPeopleOfInterest, const Color(colorPeopleOfInterest),
            AppLocalizations.of(context)!.calendar_people_of_interests_05)
      ],

      // Dec
      DateTime.utc(2024, 12, 1): [
        Event(showLunarEclipse, const Color(colorLunarEclipse),
            AppLocalizations.of(context)!.lunarEclipse)
      ],
      DateTime.utc(2024, 12, 13): [
        Event(showReligiousOccasion, const Color(colorReligiousOccasion),
            AppLocalizations.of(context)!.calendar_event_abuAlhiris),
        Event(showBeginningOfMonth, const Color(colorBeginningOfTheMonth),
            AppLocalizations.of(context)!.calendar_beginning_of_month_12)
      ],
      DateTime.utc(2024, 12, 21): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting)
      ],
      DateTime.utc(2024, 12, 27): [
        Event(showLightDayOfFasting, const Color(colorLightDayOfFasting),
            AppLocalizations.of(context)!.calendar_light_fasting),
        Event(showPeopleOfInterest, const Color(colorPeopleOfInterest),
            AppLocalizations.of(context)!.calendar_people_of_interests_06)
      ],
      DateTime.utc(2024, 12, 30): [
        Event(showLunarEclipse, const Color(colorLunarEclipse),
            AppLocalizations.of(context)!.lunarEclipse)
      ],
    };

    events.addAll(eventsInternal);
    calendar.refreshCalendar();
  }
}

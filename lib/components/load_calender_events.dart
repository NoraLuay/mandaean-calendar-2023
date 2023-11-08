import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../utils.dart';
import 'calendar_events.dart';
import 'package:mandaean_calendar_2022/utils.dart';

class LoadCalendarEvents {
  var calendar = const CalendarEvents();

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
}

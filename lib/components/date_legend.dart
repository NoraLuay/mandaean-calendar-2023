import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mandaean_calendar_2022/util/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class DateLegend extends StatefulWidget {
  final String name;
  final int hexColor;
  Function(bool isSwitched) callBack;

  DateLegend(this.name, this.hexColor, this.callBack, {Key? key})
      : super(key: key);

  @override
  _DateLegend createState() => _DateLegend(this.name, this.hexColor, callBack);
}

class _DateLegend extends State<DateLegend> {
  bool isSwitched = false;

  String name;
  int hexColor;
  Function(bool isSwitched) callBack;

  _DateLegend(this.name, this.hexColor, this.callBack);

  @override
  void initState() {
    super.initState();
    loadEventToggle(context);
  }

  void _onChanged(bool value) {
    setState(() {
      isSwitched = value;
      callBack(value);
    });
  }

  Future<void> loadEventToggle(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    switch (hexColor) {
      case colorReligiousOccasion:
        {
          setState(() {
            isSwitched = prefs.getBool(religiousOccasionKey) ?? true;
          });
        }
        break;
      case colorBeginningOfTheMonth:
        {
          setState(() {
            isSwitched = prefs.getBool(beginningOfTheMonthKey) ?? true;
          });
        }
        break;
      case colorLightDayOfFasting:
        {
          setState(() {
            isSwitched = prefs.getBool(lightDayOfFastingKey) ?? true;
          });
        }
        break;
      case colorHeavyDayOfFasting:
        {
          setState(() {
            isSwitched = prefs.getBool(heavyDayOfFastingKey) ?? true;
          });
        }
        break;
      case colorPeopleOfInterest:
        {
          setState(() {
            isSwitched = prefs.getBool(peopleOfInterestKey) ?? true;
          });
        }
        break;
      case colorLunarEclipse:
        {
          setState(() {
            isSwitched = prefs.getBool(lunarEclipseKey) ?? true;
          });
        }
        break;
      case colorPredictionDay:
        {
          setState(() {
            isSwitched = prefs.getBool(predictionDayKey) ?? true;
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyScrollBehavior(),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: const Color(colorEventBorder)),
                color: Color(hexColor),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(child: Text(name, style: const TextStyle(fontSize: 16.0))),
            SizedBox(
                height: 30,
                child: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      _onChanged(value);
                    }))
          ]),
        ],
      ),
    );
  }
}

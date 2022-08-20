import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            isSwitched = prefs.getBool(religiousOccasionKey) ?? false;
          });
        }
        break;
      case colorBeginningOfTheMonth:
        {
          setState(() {
            isSwitched = prefs.getBool(beginningOfTheMonthKey) ?? false;
          });
        }
        break;
      case colorLightDayOfFasting:
        {
          setState(() {
            isSwitched = prefs.getBool(lightDayOfFastingKey) ?? false;
          });
        }
        break;
      case colorHeavyDayOfFasting:
        {
          setState(() {
            isSwitched = prefs.getBool(heavyDayOfFastingKey) ?? false;
          });
        }
        break;
      case colorPeopleOfInterest:
        {
          setState(() {
            isSwitched = prefs.getBool(peopleOfInterestKey) ?? false;
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
    );
  }
}

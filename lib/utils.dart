// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:ui';

import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final Color color;

  const Event(this.color, this.title);

  @override
  String toString() => title;
}

final kEvents = {
  DateTime.utc(2022, 8, 6): [
    const Event(Color(0xFFFFC800), 'Today\'s Event 1'),
    const Event(Color(0xFF14C815), 'Today\'s Event 2'),
  ]
};

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month, kToday.day);

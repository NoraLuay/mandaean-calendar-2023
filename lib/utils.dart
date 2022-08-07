// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:ui';

import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final Color color;
  final bool display;

  const Event(this.display, this.color, this.title);

  @override
  String toString() => title;
}

final events = {};

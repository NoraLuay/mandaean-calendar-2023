// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants.dart';
import '../utils.dart';

DateTime? _selectedDay;
ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);

List<Event> _getEventsForDay(DateTime day) {
  return events[day] ?? [];
}

class CalendarEvents extends StatefulWidget {
  const CalendarEvents();

  void refreshCalendar() {
    _selectedEvents.value.clear();
    _selectedEvents.value = _getEventsForDay(_selectedDay!);
  }

  @override
  _CalendarEventsState createState() => _CalendarEventsState();
}

class _CalendarEventsState extends State<CalendarEvents> {
  DateTime _focusedDay = DateTime.now();

  _CalendarEventsState();

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: _selectedEvents,
            builder: (BuildContext context, List<Event> value, Widget? child) {
              return TableCalendar<Event>(
                locale: Localizations.localeOf(context).toString(),
                startingDayOfWeek: StartingDayOfWeek.monday,
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2023, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                availableCalendarFormats: const {
                  CalendarFormat.month: '',
                },
                calendarStyle: CalendarStyle(
                  // Weekend dates color (Sat & Sun Column)
                  weekendTextStyle: const TextStyle(color: Color(0xFFFF0000)),
                  // highlighted color for today
                  todayDecoration: BoxDecoration(
                    color: secondaryColor,
                    shape: BoxShape.rectangle,
                      border: Border.all(
                          width: 2,
                          color: primaryColor),
                  ),
                  todayTextStyle: const TextStyle(color: Colors.black),
                  selectedTextStyle: const TextStyle(color: Colors.black),
                  selectedDecoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.rectangle,
                  ),
                  outsideDaysVisible: false,
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                    titleTextFormatter: (date, locale) {
                        return DateFormat.MMMM(locale).format(date);
                    },
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    final children = <Widget>[];
                    if (events.isNotEmpty) {
                      for (var eve in events) {
                        if (eve.display) {
                          children.add(
                            Container(
                              height: 12.0,
                              width: 12.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: const Color(colorEventBorder)),
                                color: eve.color,
                              ),
                            ),
                          );
                        }
                      }
                    }

                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: children);
                  },
                ),
                eventLoader: _getEventsForDay,
                onDaySelected: _onDaySelected,
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                  if (_selectedDay?.month == focusedDay.month) {
                      var eve = _getEventsForDay(_selectedDay!);
                      _selectedEvents.value = eve;
                  } else {
                    _selectedEvents.value = [];
                  }
                },
              );
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    if (value[index].display &&
                        _selectedDay?.month == _focusedDay.month) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: value[index].color,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text(value[index].title),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';

class TableEventsExample extends StatefulWidget {
  const TableEventsExample();

  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  _TableEventsExampleState();

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

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
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
          TableCalendar<Event>(
            locale: Localizations.localeOf(context).toString(),
            startingDayOfWeek: StartingDayOfWeek.monday,
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2022, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            availableCalendarFormats: const {
              CalendarFormat.month: '',
            },
            calendarStyle: const CalendarStyle(
              // Weekend dates color (Sat & Sun Column)
              weekendTextStyle: TextStyle(color: Color(0xFFFF0000)),
              // highlighted color for today
              todayDecoration: BoxDecoration(
                color: Color(0x800064FF),
                shape: BoxShape.rectangle,
              ),
              // highlighted color for selected day
              selectedDecoration: BoxDecoration(
                color: Color(0xFF0064FF),
                shape: BoxShape.rectangle,
              ),
              outsideDaysVisible: false,
            ),
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                final children = <Widget>[];
                if (events.isNotEmpty) {
                  for (var eve in events) {
                    children.add(
                      Container(
                        height: 12.0,
                        width: 12.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: const Color(0xFF4788C7)),
                          color: eve.color,
                        ),
                      ),
                    );
                  }
                }

                return Row(children: children);
              },
            ),
            eventLoader: _getEventsForDay,
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
              if (_selectedDay == focusedDay) {
                _selectedEvents.value = _getEventsForDay(_selectedDay!);
              } else {
                _selectedEvents.value = [];
              }
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
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('wtf ${value[index]}'),
                        title: Text(value[index].title),
                      ),
                    );
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

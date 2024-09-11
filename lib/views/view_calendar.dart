/*  lib  views  CALENDAR  */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/calendarviewmodel.dart';

class CalendarView extends StatelessWidget {
  final CalendarViewModel viewModel;
  const CalendarView({
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<CalendarViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Calendar'),
            ),
            // body: _buildCalendarView(viewModel),
          );
        },
      ),
    );
  }
  //   switch (viewModel.config.view) {
  //     case CalendarView.year:
  //       return YearCalendarView(date: viewModel.config.selectedDate);
  //     case CalendarView.month:
  //       return MonthCalendarView(date: viewModel.config.selectedDate);
  //     case CalendarView.week:
  //       return WeekCalendarView(date: viewModel.config.selectedDate);
  //     case CalendarView.day:
  //       return DayCalendarView(date: viewModel.config.selectedDate);
  //     default:
  //       return Container(); // Fallback
  //   }
  // }
}

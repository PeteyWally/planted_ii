/*  lib  views  CALENDAR  */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/calendarviewmodel.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarViewModel = Provider.of<CalendarViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(":Calendar:"),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: calendarViewModel.categories.length,
              itemBuilder: (context, index) {
                final category = calendarViewModel.categories[index];
                return ListTile(
                  title: Text(category.name),
                );
              },
            ),
          ),

        // ElevatedButton(
        //   onPressed: () {
        //     calendarViewModel.addWidget('New Widget ${calendarViewModel.widgets.length}', '/newRoute');
        //   },
        //   child: Icon(Icons.add),
        // ),


        ],
      ),
    );
  }
}
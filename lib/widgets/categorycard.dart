/*  lib  widget  CATEGORY-CARD  */

import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final List<String> subtasks;
  
  CategoryCard({
    required this.title,
    required this.subtasks,
  });


  @override
  Widget build(BuildContext context) {
    return Card(

      child: ListTile(
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: subtasks.map((task) => Text(task)).toList(),
        ),
      ),

    );
  }

}
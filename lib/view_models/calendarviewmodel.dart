/*  lib  viewmodels  CALENDAR  */

import 'package:flutter/material.dart';
import '../models/model_category.dart';

class CalendarViewModel extends ChangeNotifier {
  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => _categories;

  void addCategoryToCalendar(CategoryModel category) {
    _categories.add(category);
    notifyListeners();
  }

  void updateCategoryInCalendar(CategoryModel category) {
//TODO: Implement update logic
    notifyListeners();
  }

}


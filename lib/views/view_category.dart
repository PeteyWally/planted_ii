/*  lib  views  CATEGORY  */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/categoryviewmodel.dart';
import '../widgets/categorycard.dart';
import '../models/model_task.dart';

class CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryViewModel = Provider.of<CategoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(':Categories:'),
      ),
      body: categoryViewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: categoryViewModel.categories.length,
              itemBuilder: (context, index) {
                final category = categoryViewModel.categories[index];
                return FutureBuilder<List<TaskModel>>(
                  future: categoryViewModel.fetchSubTasks(category.subTaskIds),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Text(category.name),
                        subtitle: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return ListTile(
                        title: Text(category.name),
                        subtitle: Text('Error loading tasks'),
                      );
                    } else if (snapshot.hasData) {
                      final tasks = snapshot.data!;
                      return CategoryCard(
                        title: category.name,
                        estimatedTime: category.sizeTime.toString(),
                        subtasks: tasks.map((task) => task.name).toList(),
                      );
                    } else {
                      return ListTile(
                        title: Text(category.name),
                        subtitle: Text('No tasks available'),
                      );
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new category logic
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

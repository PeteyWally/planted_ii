/*  lib  views  GRID  */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/categoryviewmodel.dart';
import '../widgets/flexiblewij.dart';
import '../models/model_category.dart';
import '../widgets/gridlines.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryViewModel = Provider.of<CategoryViewModel>(context);

    if (categoryViewModel.isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading Grid...'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(':Griddy Boiiii:'),
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: categoryViewModel.getBlocksForGrid(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          }

          final categories = snapshot.data!;
          final double cellWidth = MediaQuery.of(context).size.width / 14;
          final double cellHeight = 50.0; // Define the height of the rows

          return Stack(
            children: [
              // Background grid
              CustomPaint(
                size: Size(double.infinity, double.infinity),
                painter: GridPainter(
                  rows: 7,
                  columns: 14,
                  cellWidth: cellWidth,
                  cellHeight: cellHeight,
                ),
              ),
              // Existing content
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 0.0,
                      runSpacing: 0.0,
                      children: categories.map((category) {
                        final width = category.sizeTime.toDouble();
                        return FlexibleWij(
                          category: category,
                          widgetWidth: width,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

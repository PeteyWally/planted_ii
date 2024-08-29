/*  lib  views  GRID  */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/categoryviewmodel.dart';
import '../widgets/flexiblewij.dart';
import '../models/model_category.dart';

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

/* OPTION 1 - Sliver Grid */
//               return CustomScrollView(
//                 slivers: [
//                   SliverGrid(
//                     delegate: SliverChildBuilderDelegate(
//                       (context, index) {
// //calc ROW COLUMN from index
//                         if (index < blocks.length) {
//                           final block = blocks[index];
//                           return FlexibleWij(
//                             item: block,
//                             width: block.sizeTime.toDouble(),
//                           );
//                         }
//                         return SizedBox.shrink();
//                       },
//                       childCount: blocks.length,
//                     ),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 24,
//                       childAspectRatio: 1.0,
//                     ),
//                   )
//                 ],
//               );

/* OPTION 2 - GridView */
            // return GridView.builder(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 24,
            //     childAspectRatio: 1.0,
            //   ),
            //   itemCount: blocks.length,
            //   itemBuilder: (context, index) {
            //     final block = blocks[index];
            //     return FlexibleWij(
            //       item: block,
            //       width: block.sizeTime.toDouble(),
            //     );
            //   },
            // );

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: categories.map((category) {
                  // final width = categoryViewModel.calculateWidth(block);
                  final width = category.sizeTime.toDouble();
                  return FlexibleWij(
                    category: category,
                    width: width,
                  );
                }).toList(),
              ),
            );
          },
        ));
  }
}
